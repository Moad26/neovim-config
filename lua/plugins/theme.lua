return {
  {
    "bluz71/vim-nightfly-guicolors",
    priority = 1000,
    config = function()
      vim.g.nightflyItalics = true
      vim.g.nightflyCursorColor = true
      vim.g.nightflyNormalFloat = true
      vim.g.nightflyWinSeparator = 2
    end,
  },
  {
    "folke/tokyonight.nvim",
  },
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "soft"
    end,
  },
  {
    "catppuccin/nvim",
  },
  {
    "rebelot/kanagawa.nvim",
  },
  {
    "sainnhe/gruvbox-material",
  },
  {
    "rose-pine/neovim",
  },
  {
    "navarasu/onedark.nvim",
  },
  {
    "EdenEast/nightfox.nvim",
  }
}
