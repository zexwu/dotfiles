-- since this is just an example spec, don't actually load anything here and return an empty spec

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
    -- change trouble config
    {
        "folke/trouble.nvim",
        -- opts will be merged with the parent spec
        opts = { use_diagnostic_signs = true },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {
            transparent = true,
            style = "moon",
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },

    -- disable trouble
    { "folke/trouble.nvim", enabled = false },
    { "ellisonleao/gruvbox.nvim" },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
    },

    -- disable scrolling
    {
        "snacks.nvim",
        opts = {
            scroll = { enabled = false },
            -- image = { convert = { notify = false } },
        },
    },

    -- add more treesitter parsers
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "tsx",
                "typescript",
                "vim",
                "yaml",
                "latex",
            },
        },
    },

    -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
    -- would overwrite `ensure_installed` with the new value.
    -- If you'd rather extend the default config, use the code below instead:
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- add tsx and treesitter
            vim.list_extend(opts.ensure_installed, {
                "tsx",
                "typescript",
            })
        end,
    },

    -- add any tools you want to have installed below
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "stylua",
                "shellcheck",
                "shfmt",
                "flake8",
                "black",
                "isort",
            },
        },
    },

    -- rainbow_csv
    {
        "cameron-wags/rainbow_csv.nvim",
        config = true,
        ft = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim",
        },
    },

    -- language support
    {
        "keaising/im-select.nvim",
        lazy = false,
        opts = {
            default_im_select = "com.apple.keylayout.ABC",
            default_command = "im-select",
        },
    },

    -- show color in terminal
    {
        "norcalli/nvim-colorizer.lua",
    },
}
