return {
  {
    "williamboman/mason.nvim",
    config = true,
    enabled = true,
    lazy = true,
  },
  {
    "williamboman/mason-lspconfig",
    config = function()
      require("plugins.lsp.mason")
    end,
  },
}
