return {
    "L3MON4D3/LuaSnip",
    lazy = true,
    build = (not LazyVim.is_win())
            and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
        or nil,
    dependencies = {
        {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
            end,
        },
    },
    opts = {
        history = true,
        delete_check_events = "TextChanged",
        enable_autosnippets = true,
    },
    config = function(_, opts)
        local ls = require("luasnip")
        ls.setup(opts)
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/luasnippets/" })
    end,
    keys = {
        {
            "<tab>",
            function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true,
            silent = true,
            mode = "i",
        },
        {
            "<tab>",
            function()
                require("luasnip").jump(1)
            end,
            mode = "s",
        },
        {
            "<s-tab>",
            function()
                require("luasnip").jump(-1)
            end,
            mode = { "i", "s" },
        },
    },
}
