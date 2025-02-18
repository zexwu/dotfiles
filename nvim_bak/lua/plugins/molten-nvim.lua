return {
    "benlubas/molten-nvim",
    version = "1.8.0", -- use version <2.0.0 to avoid breaking changes
    build = ":UpdateRemotePlugins",
    init = function()
        -- this is an example, not a default. Please see the readme for more configuration options
        vim.g.molten_output_win_max_height = 12
        vim.g.molten_auto_image_popup = false
        vim.g.molten_image_provider = "wezterm"
        vim.g.molten_auto_open_output = false
        vim.g.molten_virt_text_output = true 
        vim.g.molten_enter_output_behavior = "open_and_enter"
        -- vim.g.molten_image_location = "virt"
    end,
    keys = {
        -- { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
        -- {
        --     "<leader>ge",
        --     function()
        --         require("neo-tree.command").execute({ source = "git_status", toggle = true })
        --     end,
        --     desc = "Git Explorer",
        -- },
        { "<leader>mi", ":MoltenInit<CR>", desc = "Initialize kernel", mode = { "n" }, silent = true },
        { "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Evaluate line", mode = { "n", "v" }, silent = true },
        { "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>", desc = "Evaluate visual selection", mode = { "v" }, silent = true },
        { "<leader>md", ":MoltenDelete<CR>", desc = "Delete cell", mode = { "n" }, silent = true },
        { "<leader>mh", ":MoltenHideOutput<CR>", desc = "Hide output", mode = { "n" }, silent = true },
        { "<leader>ms", ":noautocmd MoltenEnterOutput<CR>", desc = "show/enter output", mode = { "n" }, silent = true },
        { "<leader>mn", ":MoltenNext 1<CR>", desc = "Next output", mode = { "n" }, silent = true },
        { "<leader>mp", ":MoltenPrev 1<CR>", desc = "Prev output", mode = { "n" }, silent = true },
        { "<leader>mm", ":MoltenImagePopup<CR>", desc = "Poput image", mode = { "n" }, silent = true },
        { "<leader>mr", ":MoltenReevaluateCell<CR>", desc = "Re-evaluate cell", mode = { "n" }, silent = true },
    },
}
