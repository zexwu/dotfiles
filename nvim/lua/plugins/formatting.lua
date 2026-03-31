return {
  {
    "stevearc/conform.nvim",
    opts = {
      default_format_opts = {
        timeout_ms = 30000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        python = { "black", "isort" },
        fortran = { "findent" },
        tex = { "latex_indent" },
        shell = { "shfmt" },
        zsh = { "beautysh" },
      },
      formatters = {
        findent = {
          prepend_args = { "-i4" },
        },
        black = {
          prepend_args = { "--line-length", "119" },
        },
      },
    },
  },
}
