local M = {}

-- simple storage for surrounds
M.surrounds = {
  {
    name = "try/catch",
    before = "try {\n",
    after = "\n} catch (e) {\n\n}",
  },
}

-- add a surround at runtime
function M.add(name, before, after)
  table.insert(M.surrounds, { name = name, before = before, after = after })
end

-- apply surround to a previously-captured selection (or current visual selection)
local function apply_to_selection(sel, s)
  if not sel then
    vim.notify("No visual selection captured", vim.log.levels.WARN)
    return
  end
  local bufnr = sel.buf
  local sr = sel.sr
  local er = sel.er
  local text = sel.text
  local new = s.before .. text .. s.after
  local new_lines = vim.split(new, "\n")
  vim.api.nvim_buf_set_lines(bufnr, sr, er + 1, false, new_lines)
end

-- public apply when called with a name; if in visual mode capture selection and apply immediately
function M.apply(name)
  local s
  for _, v in ipairs(M.surrounds) do
    if v.name == name then
      s = v
      break
    end
  end
  if not s then
    vim.notify("Surround not found: " .. name, vim.log.levels.ERROR)
    return
  end

  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '\022' then
    -- capture selection
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local sr = start_pos[2] - 1
    local er = end_pos[2] - 1
    local lines = vim.api.nvim_buf_get_lines(0, sr, er + 1, false)
    local text = table.concat(lines, "\n")
    local sel = { buf = vim.api.nvim_get_current_buf(), sr = sr, er = er, text = text }
    apply_to_selection(sel, s)
    -- leave visual mode
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', true)
  else
    vim.notify("Use visual mode to select text to surround", vim.log.levels.INFO)
  end
end

-- Telescope picker integration
function M.pick(line1, line2)
  local ok, pickers = pcall(require, "telescope.pickers")
  if not ok then
    vim.notify("Telescope not found", vim.log.levels.ERROR)
    return
  end
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- capture visual selection if present (use range when called from command)
  local sel = nil
  if line1 and line2 and line1 ~= 0 then
    local sr = line1 - 1
    local er = line2 - 1
    local lines = vim.api.nvim_buf_get_lines(0, sr, er + 1, false)
    local text = table.concat(lines, "\n")
    sel = { buf = vim.api.nvim_get_current_buf(), sr = sr, er = er, text = text }
  else
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' or mode == '\022' then
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local sr = start_pos[2] - 1
      local er = end_pos[2] - 1
      local lines = vim.api.nvim_buf_get_lines(0, sr, er + 1, false)
      local text = table.concat(lines, "\n")
      sel = { buf = vim.api.nvim_get_current_buf(), sr = sr, er = er, text = text }
      -- leave visual mode so Telescope behaves normally
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), 'n', true)
    end
  end

  local entries = {}
  -- special "Add new surround" entry
  table.insert(entries, { name = "<Add new surround>", special = true, display = "<Add new surround>" })
  for _, v in ipairs(M.surrounds) do
    table.insert(entries, { name = v.name, before = v.before, after = v.after, display = v.name })
  end

  local opts = {}
  pickers.new(opts, {
    prompt_title = "Surrounds",
    finder = finders.new_table {
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.display or entry.name,
          ordinal = entry.name,
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      local function apply_selection()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local val = selection.value
        if val.special then
          -- prompt for new surround
          local name = vim.fn.input("Name: ")
          if name == "" then return end
          local before = vim.fn.input("Before: ")
          local after = vim.fn.input("After: ")
          M.add(name, before, after)
          vim.notify("Added surround: " .. name, vim.log.levels.INFO)
          return
        end
        local s = { before = val.before, after = val.after }
        if sel then
          apply_to_selection(sel, s)
        else
          vim.notify("Select text in visual mode before using the picker, or call apply manually", vim.log.levels.INFO)
        end
      end

      actions.select_default:replace(function()
        apply_selection()
      end)
      return true
    end,
  }):find()
end

-- setup helper: create commands
function M.setup()
  vim.api.nvim_create_user_command('SurroundAdd', function(opts)
    local args = opts.fargs
    if #args < 3 then
      vim.notify('Usage: :SurroundAdd <name> <before> <after>', vim.log.levels.ERROR)
      return
    end
    M.add(args[1], args[2], args[3])
    vim.notify('Surround added: ' .. args[1], vim.log.levels.INFO)
  end, { nargs = '*', complete = nil })

  vim.api.nvim_create_user_command('SurroundPick', function(opts)
    M.pick(opts.line1, opts.line2)
  end, { nargs = 0, range = true })
end

return M
