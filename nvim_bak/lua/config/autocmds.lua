-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local agrp = vim.api.nvim_create_augroup
local acmd = vim.api.nvim_create_autocmd

local group = vim.api.nvim_create_augroup("vimtex", {})
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventViewReverse",
    group = group,
    callback = function()
        -- lua code that executes the osascript goes here, e.g. something like
        vim.fn.system("osascript -e 'activate application \"wezterm\"'")
        -- vim.fn.system("osascript -e 'activate application \"alacritty\"'")
    end,
})

local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
    local path = filename .. ".ipynb"
    local file = io.open(path, "w")
    if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. path)
    else
        print("Error: Could not open new notebook file for writing.")
    end
end

vim.api.nvim_create_user_command("NewNotebook", function(opts)
    new_notebook(opts.args)
end, {
    nargs = 1,
    complete = "file",
})
