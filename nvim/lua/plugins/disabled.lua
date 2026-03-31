return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim", "willothy/wezterm.nvim" },
    build = ":UpdateRemotePlugins",
    lazy = false,
    enabled = false,
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 25
      vim.g.molten_auto_open_output = true
      vim.g.molten_save_path = "/Users/zexwu/data/molten/"
      vim.g.molten_wrap_output = true
    end,
    keys = {
      { "<localleader>mi", ":MoltenInit<CR>", mode = "n", silent = true, desc = "Initialize the plugin" },
      { "<localleader>ms", ":MoltenSave<CR>", mode = "n", silent = true, desc = "Save current output" },
      { "<localleader>ml", ":MoltenLoad<CR>", mode = "n", silent = true, desc = "Load saved output" },
      { "<localleader>me", ":noautocmd MoltenEnterOutput<CR>", mode = "n", silent = true, desc = "Enter Cell" },
      { "<localleader>md", ":MoltenDelete<CR>", mode = "n", silent = true, desc = "Delete Cell" },
      { "<localleader>mh", ":MoltenHideOutput<CR>", mode = "n", silent = true, desc = "Hide output" },
      { "<localleader>rl", ":MoltenEvaluateLine<CR>", mode = "n", silent = true, desc = "Evaluate line" },
      { "<localleader>rr", ":MoltenReevaluateCell<CR>", mode = "n", silent = true, desc = "Re-evaluate cell" },
      { "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>", mode = "v", silent = true, desc = "Run visual" },
    },
  },
  {
    "willothy/wezterm.nvim",
    enabled = false,
    config = true,
  },
  {
    "3rd/image.nvim",
    enabled = false,
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 23,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
  {
    "epwalsh/obsidian.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      completion = {
        nvim_cmp = false,
      },
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/notes",
        },
      },
      ui = {
        enable = false,
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      local cmp = require("cmp")
      cmp.register_source("obsidian", require("cmp_obsidian").new())
      cmp.register_source("obsidian_new", require("cmp_obsidian_new").new())
      cmp.register_source("obsidian_tags", require("cmp_obsidian_tags").new())
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/nvim-mini" },
    opts = {},
  },
}
