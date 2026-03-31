return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<c-\>]], -- Shortcut to toggle the main terminal
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            direction = 'horizontal', -- This puts it at the bottom
            close_on_exit = true,
        })

        -- 2. PYTHON RUNNER LOGIC
        local Terminal = require("toggleterm.terminal").Terminal

        -- We define the terminal once
        local python_runner = Terminal:new({
            cmd = "python3", -- placeholder
            direction = "float",
            close_on_exit = false, -- Keep open to see errors/output
            on_open = function(term)
                -- Quick way to close the float with 'q' when in normal mode
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
        })

        -- Wrapper function to update the filename and run
        local function run_python()
            local file = vim.fn.expand("%")
            python_runner.cmd = "python3 " .. file
            python_runner:toggle()
        end

        -- 3. KEYMAPS
        vim.keymap.set("n", "<leader>pr", run_python, { desc = "Python: Run Current File" })
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Terminal: Toggle Float" })
    end,
}
