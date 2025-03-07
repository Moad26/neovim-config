return {
  "folke/snacks.nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    animate = {},
    bigfile = { enabled = true },
    dashboard = { example="compact_files"},
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    -- picker = { enabled = true },
    -- notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    --scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    util = { enabled = true },
  },
}
