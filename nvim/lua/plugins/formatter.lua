return {
    {
        "stevearc/conform.nvim",
        default_format_opts = {
            timeout_ms = 30000,
            async = false, -- not recommended to change
            quiet = false, -- not recommended to change
            lsp_format = "fallback", -- not recommended to change
        },
        opts = {
            formatters_by_ft = {
                ["python"] = { "black", "isort" },
                ["fortran"] = { "findent" },
                ["tex"] = { "latex_indent" },
                ["shell"] = { "shfmt" },
                ["zsh"] = { "beautysh" },
            },
        },
        formatters = {
            findent = {
                prepend_args = { "-i4" },
            },
            black = {
                -- Check for a local config; if not found, use this argument
                prepend_args = { "--line-length", "119" },
            },
        },
    },
}
