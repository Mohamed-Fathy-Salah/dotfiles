local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.cmd("source /home/mofasa/.config/nvim/sets.vim")
vim.cmd("source /home/mofasa/.config/nvim/keymaps.vim")

require("plugins")

local dap = require("dap")

local function run_until_error()
    dap.set_breakpoint(nil, nil, "exception") 
    dap.continue() 
end

local function build_and_debug()
   if dap.session() then
        dap.continue()
        return
    end
    local project_path = vim.fn.getcwd() 
    local build_command = "dotnet build " .. project_path
    local result = vim.fn.system(build_command)
    if vim.v.shell_error ~= 0 then
        print("Build failed: " .. result)
        return
    end
    dap.continue()
end

vim.keymap.set("n", "<F5>", build_and_debug) -- Build and debug
vim.keymap.set("n", "<F6>", run_until_error) -- Run until error
