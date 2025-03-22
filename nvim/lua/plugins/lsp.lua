return {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
        ---@type lspconfig.options
        servers = {
            -- pyright will be automatically installed with mason and loaded with lspconfig
            pyright = {
                enabled = true,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = false,
                            diagnosticMode = "openFilesOnly",

                            useLibraryCodeForTypes = true,
                            typeCheckingMode = "standard",
                            diagnosticSeverityOverrides = {
                                reportGeneralTypeIssues = "none",
                                reportOptionalSubscript = "none",
                                reportUnboundVariable = "none",
                                reportOptionalMemberAccess = "none",
                                reportInvalidStringEscapeSequence = "none",
                                reportOptionalOperand = "none",
                                reportAttributeAccessIssue = "none",
                                reportOperatorIssue = "none",
                                reportArgumentType = "none",
                                reportIndexIssue = "none",
                                reportCallIssue = "none",
                                reportOptionalCall = "none",
                                reportPrivateImportUsage = "none",
                            },
                        },
                    },
                    single_file_support = true,
                },
            },
            fortls = {},
        },
    },
}
