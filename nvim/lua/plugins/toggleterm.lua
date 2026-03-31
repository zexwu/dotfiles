return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
    })

    local Terminal = require("toggleterm.terminal").Terminal
    local python_runner = Terminal:new({
      cmd = "python3",
      direction = "float",
      close_on_exit = false,
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    local function run_python()
      local file = vim.fn.expand("%")
      python_runner.cmd = "python3 " .. file
      python_runner:toggle()
    end

    vim.keymap.set("n", "<leader>pr", run_python, { desc = "Python: Run Current File" })
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Terminal: Toggle Float" })
  end,
}
