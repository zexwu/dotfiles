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
            },
        },
    },
}
