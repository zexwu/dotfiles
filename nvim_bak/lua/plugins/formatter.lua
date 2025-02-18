local Util = require("lazyvim.util")

local M = {}

---@param opts ConformOpts
function M.setup(_, opts)
    for name, formatter in pairs(opts.formatters or {}) do
        if type(formatter) == "table" then
            ---@diagnostic disable-next-line: undefined-field
            if formatter.extra_args then
                ---@diagnostic disable-next-line: undefined-field
                formatter.prepend_args = formatter.extra_args
                Util.deprecate(
                    ("opts.formatters.%s.extra_args"):format(name),
                    ("opts.formatters.%s.prepend_args"):format(name)
                )
            end
        end
    end

    for _, key in ipairs({ "format_on_save", "format_after_save" }) do
        if opts[key] then
            Util.warn(
                ("Don't set `opts.%s` for `conform.nvim`.\n**LazyVim** will use the conform formatter automatically"):format(
                    key
                )
            )
            ---@diagnostic disable-next-line: no-unknown
            opts[key] = nil
        end
    end
    require("conform").setup(opts)
end

return {
    {
        "stevearc/conform.nvim",
        dependencies = { "mason.nvim" },
        lazy = true,
        cmd = "ConformInfo",
        keys = {
            {
                "<leader>cF",
                function()
                    require("conform").format({ formatters = { "injected" } })
                end,
                mode = { "n", "v" },
                desc = "Format Injected Langs",
            },
        },
        init = function()
            -- Install the conform formatter on VeryLazy
            require("lazyvim.util").on_very_lazy(function()
                require("lazyvim.util").format.register({
                    name = "conform.nvim",
                    priority = 100,
                    primary = true,
                    format = function(buf)
                        local plugin = require("lazy.core.config").plugins["conform.nvim"]
                        local Plugin = require("lazy.core.plugin")
                        local opts = Plugin.values(plugin, "opts", false)
                        require("conform").format(Util.merge(opts.format, { bufnr = buf }))
                    end,
                    sources = function(buf)
                        local ret = require("conform").list_formatters(buf)
                        ---@param v conform.FormatterInfo
                        return vim.tbl_map(function(v)
                            return v.name
                        end, ret)
                    end,
                })
            end)
        end,
        opts = function()
            local plugin = require("lazy.core.config").plugins["conform.nvim"]
            ---@class ConformOpts
            local opts = {
                -- LazyVim will use these options when formatting with the conform.nvim formatter
                format = {
                    timeout_ms = 20000,
                    async = false, -- not recommended to change
                    quiet = false, -- not recommended to change
                },
                -- format_on_save = nil,
                -- format_after_save = nil,
                ---@type table<string, conform.FormatterUnit[]>
                formatters_by_ft = {
                    lua = { "stylua" },
                    fish = { "fish_indent" },
                    sh = { "shfmt" },
                    python = { "isort", "black" },
                    tex = { "latexindent" },
                    toml = { "tomlfmt" },
                    fortran = { "fprettify" },
                    cpp = { "clang-format" },
                    html = { "prettier" },
                },
                -- The options you set here will be merged with the builtin formatters.
                -- You can also define any custom formatters here.
                ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
                formatters = {
                    injected = { options = { ignore_errors = true } },
                    -- # Example of using dprint only when a dprint.json file is present
                    -- dprint = {
                    --   condition = function(ctx)
                    --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
                    --   end,
                    -- },
                    --
                    -- # Example of using shfmt with extra args
                    -- shfmt = {
                    --   prepend_args = { "-i", "2", "-ci" },
                    -- },
                    prettier = {
                        command = "/Users/zexwu/.local/share/nvim/mason/bin/prettier",
                        prepend_args = { "--tab-width", "4"},
                    },
                    tomlfmt = {
                        command = "/Users/zexwu/.nvm/versions/node/v20.15.1/bin/prettier",
                        args = {
                            "--plugin",
                            "/Users/zexwu/.nvm/versions/node/v20.15.1/lib/node_modules/prettier-plugin-toml/lib/index.cjs",
                        },
                    },
                },
            }
            return opts
        end,
    },
}
