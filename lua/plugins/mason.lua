return {
  {
    'williamboman/mason-lspconfig',
  },
  { 'jayp0521/mason-null-ls.nvim' },
  {
    'williamboman/mason.nvim',
    config = function()
      require('plugins.lsp.mason')
    end,
  },
}
