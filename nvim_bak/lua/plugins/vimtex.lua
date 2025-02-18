return {
    "lervag/vimtex",
    ft = { "tex" },
    lazy = false,
    init = function()
        -- vim.g.vimtex_view_enabled = 0
        vim.g.vimtex_view_skim_sync = 1
        vim.g.vimtex_view_method = "skim"
        vim.g.vimtex_view_skim_activate = 1
        -- vim.g.vimtex_view_general_options = [[--unique file:@pdf\#src:@line@tex]]
        vim.g.vimtex_quickfix_enabled = 1
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_syntax_conceal_disable = 1
        vim.g.vimtex_compiler_latexmk = { aux_dir = "./tmp/", out_dir = "./tmp/", synctex = 0 }
    end,
}
