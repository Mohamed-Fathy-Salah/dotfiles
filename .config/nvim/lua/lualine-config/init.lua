require('lualine').setup{
    options = {
        component_separators = '|',
        section_separators = { left = '', right = '' },
        theme = 'gruvbox'
    },
    sections = {
        lualine_a = {
            { 'mode', right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 'fileformat' },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
            { 'location', left_padding = 2 },
        },
    },
}

