return {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
        filesystem = {
            filtered_items = {
                visible = true, -- Show hidden files by default
                hide_dotfiles = false,
                hide_gitignored = false,
            },
            follow_current_file = {
                enabled = true, -- Focus the current file in the tree
            },
        },
        window = {
            position = "left", -- Move tree to the right side
            width = 27,
        },
    },
}
