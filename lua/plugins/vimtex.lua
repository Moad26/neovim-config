return {
  {
    "lervag/vimtex",
    lazy = false,  -- Make sure VimTeX is loaded immediately
    config = function()
      vim.g.vimtex_view_method = "zathura"  -- Example VimTeX setting
    end,
  },
}

