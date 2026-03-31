return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      pyright = {
        enabled = true,
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfig.json",
          ".git",
        },
        single_file_support = false,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "standard",
              diagnosticSeverityOverrides = {
                reportArgumentType = "none",
                reportAttributeAccessIssue = "none",
                reportCallIssue = "none",
                reportGeneralTypeIssues = "none",
                reportIndexIssue = "none",
                reportInvalidStringEscapeSequence = "none",
                reportOperatorIssue = "none",
                reportOptionalCall = "none",
                reportOptionalMemberAccess = "none",
                reportOptionalOperand = "none",
                reportOptionalSubscript = "none",
                reportPrivateImportUsage = "none",
                reportUnboundVariable = "none",
              },
            },
          },
        },
      },
      basedpyright = {
        enabled = false,
      },
      texlab = {
        settings = {
          texlab = {
            diagnostics = {
              ignoredPatterns = {
                "Undefined reference",
                "Package hyperref Warning",
                "Underfull",
                "Overfull",
              },
            },
          },
        },
      },
      fortls = {},
      ruff = {
        cmd_env = vim.empty_dict(),
        root_markers = {
          "pyproject.toml",
          "ruff.toml",
          ".ruff.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          ".git",
        },
        single_file_support = false,
        init_options = {
          settings = {
            logLevel = "error",
            lint = {
              ignore = { "E701", "E702", "E703", "E712", "E731" },
            },
          },
        },
      },
    },
  },
}
