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

  {
    "neovim/nvim-lspconfig",
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
  {
    "simrat39/inlay-hints.nvim",
  },
}
