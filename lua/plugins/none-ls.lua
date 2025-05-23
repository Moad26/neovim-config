return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.beautysh,
        null_ls.builtins.diagnostics.cmakelint,
        null_ls.builtins.formatting.cmakelang,
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
