local scopes = { o = vim.o, b = vim.bo, w = vim.wo, g = vim.g }
local indent = 4

local function opt(scope, key, value)
	scopes[scope][key] = value
	if scopes ~= "o" then
		scopes["o"][key] = value
	end
end

-- vim.g.did_load_filetypes = 1

opt("g", "redrawtime", 10000)
opt("g", "lazyredraw", true)
opt("b", "expandtab", true) -- Use spaces instead of tabs
opt("b", "shiftwidth", indent) -- Size of an indent
opt("b", "smartindent", true) -- Insert indents automatically
opt("b", "tabstop", indent) -- Number of spaces tabs count for
opt("o", "smarttab", true)
opt("b", "expandtab", true)
opt("o", "mouse", "a") -- Enables a mouse mode
opt("o", "hidden", true) -- Enable modified buffers in background
opt("o", "ignorecase", true) -- Ignore case
opt("o", "joinspaces", false) -- No double spaces with join after a dot
opt("o", "scrolloff", 4) -- Lines of context
opt("o", "shiftround", true) -- Round indent
opt("o", "sidescrolloff", 4) -- Columns of context
opt("o", "incsearch", true)
opt("o", "gdefault", true)
opt("o", "smartcase", true) -- Don't ignore case with capitals
opt("o", "splitbelow", true) -- Put new windows below current
opt("o", "splitright", true) -- Put new windows right of current
opt("o", "termguicolors", true) -- True color support
opt("o", "wildmode", "longest:full,full") -- Command-line completion mode
opt("w", "list", true) -- Show some invisible characters (tabs etc.)
opt("w", "number", true) -- Print line number
opt("w", "relativenumber", true) -- Relative line numbers
opt("w", "wrap", false) -- Disable line wrap
opt("o", "clipboard", "unnamedplus")
opt("o", "title", true)
opt("o", "updatetime", 100)
opt("o", "backup", false)
opt("o", "ruler", true)
opt("o", "signcolumn", "yes")
opt("o", "autoindent", true)
opt("o", "cindent", true)
opt("o", "showmode", true)
opt("o", "showcmd", true)
opt("o", "encoding", "UTF-8")
opt("o", "backspace", "indent,eol,start")
opt("o", "cmdheight", 1)
opt("o", "undofile", false)
opt("o", "completeopt", "menu,menuone,noselect")
opt("o", "shortmess", "csa")
opt("o", "background", "dark")

vim.cmd([[
    set noswapfile
]])

vim.cmd([[
    syntax on
]])

-- Event listeners

addEventListener('LuaHighlight', { 'TextYankPost * silent!' }, function ()
    require('vim.highlight').on_yank{ timeout = 250 }
end)
