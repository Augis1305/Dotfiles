require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'go',
    'javascript',
    'typescript',
    'json',
    'jsonc',
    'jsdoc',
    'lua',
    'python',
    'rust',
    'html',
    'css',
    'toml',
    'fish',
    'comment',
    'dot',
    'yaml',
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },
})
