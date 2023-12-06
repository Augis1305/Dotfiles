local indent = 2

local options = {
  redrawtime = 1000,
  -- lazyredraw = true,
  expandtab = true, -- Use spaces instead of tabs
  smartindent = true, -- Insert indents automatically
  tabstop = indent, -- Numbfer of spaces tabs count for
  shiftwidth = indent,
  smarttab = true,
  mouse = 'a', -- Enabels mouse mode
  hidden = true, -- Enable modified buffers in background
  ignorecase = true, -- Ingnore cases
  joinspaces = false, -- No double spaces with join after a dot
  scrolloff = 4, -- Lines of context
  shiftround = true,
  sidescrolloff = 4,
  incsearch = true,
  gdefault = true,
  smartcase = true,
  splitbelow = true,
  splitright = true,
  termguicolors = true,
  wildmode = 'longest:full,full',
  list = true, -- Show some invisible characters (tabs, etc)
  number = true, -- print line number
  relativenumber = true,
  wrap = false,
  clipboard = 'unnamedplus',
  title = true,
  updatetime = 100,
  backup = false,
  ruler = true,
  signcolumn = 'yes',
  cindent = true,
  showmode = true,
  showcmd = true,
  encoding = 'utf-8',
  backspace = 'indent,eol,start',
  cmdheight = 1,
  undofile = false,
  completeopt = 'menu,menuone,noselect',
  shortmess = 'csa',
  background = 'dark',
  cursorline = true,
  cursorlineopt = 'number',
  colorcolumn = '80',
}

vim.cmd([[
  set noswapfile
]])

vim.cmd([[
  syntax on
]])

vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"

for k, v in pairs(options) do
  vim.opt[k] = v
end
