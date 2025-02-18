return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        --[[ things you want to change go here]]

        active = true,
        on_config_done = nil,
        -- size can be a number or function which is passed the current terminal
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = false,
        -- shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = false,
        -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
        direction = "horizontal",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
            -- The border key is *almost* the same as 'nvim_win_open'
            -- see :h nvim_win_open for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
            border = "curved",
            -- width = <value>,
            -- height = <value>,
            winblend = 0,
            highlights = {
                border = "Normal",
                background = "Normal",
            },
        },
        -- Add executables on the config.lua
        -- { exec, keymap, name}
        -- lvim.builtin.terminal.execs = {{}} to overwrite
        -- lvim.builtin.terminal.execs[#lvim.builtin.terminal.execs+1] = {"gdb", "tg", "GNU Debugger"}
        -- TODO: pls add mappings in which key and refactor this
    },
}
