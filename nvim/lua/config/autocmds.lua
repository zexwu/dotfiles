-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local autocmd = vim.api.nvim_create_autocmd
autocmd("Filetype", {
    pattern = { "*" },
    callback = function()
        -- vim.opt.formatoptions = vim.opt.formatoptions - "o"
        if vim.bo["ft"] == "css" then
            vim.opt_local.formatoptions:remove("r") -- don't enter comment leader on Enter in css files
        end
        vim.opt.formatoptions = vim.opt.formatoptions
            + {
                o = false, -- Don't continue comments with o and O
            }
    end,
    desc = "Don't continue comments with o and O",
})
