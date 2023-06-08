return {
  {
    "glepnir/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("plugins.lsp.lspsaga")
    end,
  },
}
