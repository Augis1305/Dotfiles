return {
  -- Auto completions
  { 'hrsh7th/cmp-buffer' }, -- buffer completions
  { 'hrsh7th/cmp-path' }, -- path completions
  { 'hrsh7th/cmp-cmdline' }, -- cmdline completions
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-emoji' },
  { 'hrsh7th/cmp-nvim-lua' },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.lsp.cmp')
    end,
  },
  -- Shippets
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
}
