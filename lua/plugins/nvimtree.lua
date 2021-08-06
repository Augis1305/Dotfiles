vim.g.nvim_tree_disable_netre = 0 -- 1 by default, disables netrw
vim.g.nvim_tree_hide_dotfiles = 1 -- hide dot files
vim.g.nvim_tree_indent_markers = 1 -- show indent on open folders
vim.g.nvim_tree_follow = 1 -- update cursor when opening buffer
vim.g.nvim_tree_auto_close = 1 -- close all tree when it's the last window
-- vim.g.nvim_tree_auto_ignore_ft = 'startify' -- empty by default, don't auto open tree on specific filetypes

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

vim.cmd([[source ~/.config/nvim/vimscript/nvimtree/nvimtree.vim]])
