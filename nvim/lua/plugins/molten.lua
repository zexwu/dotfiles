return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim", "wezterm.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
            vim.g.molten_auto_open_output = true
            vim.g.molten_save_path = "/Users/zexwu/data/molten/"
            vim.g.molten_wrap_output = true
            vim.g.molten_tick_rate = 500
            -- vim.g.molten_output_win_style = "minimal"
        end,
        keys = {
            { "<localleader>mi", ":MoltenInit<CR>", mode = "n", silent = true, desc = "Initialize the plugin" },
            { "<localleader>ms", ":MoltenSave<CR>", mode = "n", silent = true, desc = "Save current output" },
            { "<localleader>ml", ":MoltenLoad<CR>", mode = "n", silent = true, desc = "Load saved output" },
            { "<localleader>me", ":noautocmd MoltenEnterOutput<CR>", mode = "n", silent = true, desc = "Enter Cell" },
            { "<localleader>md", ":MoltenDelete<CR>", mode = "n", silent = true, desc = "Delete Cell" },
            { "<localleader>mh", ":MoltenHideOutput<CR>", mode = "n", silent = true, desc = "Hide output" },
            -- { "]c", ":MoltenNext<CR>", mode = "n", silent = true, desc = "Next Molten Cell" },
            -- { "[c", ":MoltenPrev<CR>", mode = "n", silent = true, desc = "Previous Molten Cell" },
            { "<localleader>rl", ":MoltenEvaluateLine<CR>", mode = "n", silent = true, desc = "Evaluate line" },
            { "<localleader>rr", ":MoltenReevaluateCell<CR>", mode = "n", silent = true, desc = "Re-evaluate cell" },
            { "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v", silent = true, desc = "Run visual" },
        },
    },
    {
        "willothy/wezterm.nvim",
        config = true,
    },
    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            -- backend = "ueberzug", -- whatever backend you would like to use
            processor = "magick_cli", -- or "magick_rock"
            max_width = 100,
            max_height = 17,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
}
