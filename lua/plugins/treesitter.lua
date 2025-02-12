return {
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters
        max_file_lines = 1000, -- Disable for very large files
      },
    })
  end,
  dependencies = {
    "HiPhish/rainbow-delimiters.nvim",
  },
}
}
