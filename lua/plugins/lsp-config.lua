return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", "pyright", "clangd", "bashls", "cmake",
          -- Web dev LSPs
          "ts_ls",       -- TypeScript/JavaScript
          "html",        -- HTML
          "cssls",       -- CSS
          "tailwindcss", -- Tailwind CSS
          "emmet_ls",    -- Emmet for HTML/CSS
          "jsonls",      -- JSON
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Get capabilities from nvim-cmp
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setup LSPs with capabilities
      lspconfig.clangd.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } }
          }
        }
      })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.cmake.setup({ capabilities = capabilities })

      -- Web dev LSPs
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" }
      })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" }
      })
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" }
      })
      lspconfig.jsonls.setup({ capabilities = capabilities })

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {})
    end,
  },
}

