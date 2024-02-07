return {
  -- neodev
  {
    "folke/neodev.nvim",
    opts = {
      debug = true,
      experimental = {
        pathStrict = true,
      },
      library = {
        runtime = "~/neovim/runtime/",
      },
    },
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      inlay_hint = { enabled = true },
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
    },
    config = function()
      require("plugins.lsp.lspconfig")
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.lsp.null-ls")
    end,
  },
}
