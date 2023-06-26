return {
  {
    "williamboman/mason-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
    },
  },
  { "jayp0521/mason-null-ls.nvim" },
  {
    "williamboman/mason.nvim",
    config = function()
      require("plugins.lsp.mason")
    end,
  },
}
