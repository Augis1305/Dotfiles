vim.g.nvim_tree_disable_netre = 0 -- 1 by default, disables netrw
vim.g.nvim_tree_hide_dotfiles = 1 -- hide dot files
vim.g.nvim_tree_indent_markers = 1 -- show indent on open folders
vim.g.nvim_tree_follow = 1 -- update cursor when opening buffer
vim.g.nvim_tree_auto_close = 1 -- close all tree when it's the last window
vim.g.nvim_tree_auto_ignore_ft = 'startify' -- empty by default, don't auto open tree on specific filetypes

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
vim.g.nvim_tree_bindings = {
    ["<CR>"] = tree_cb("edit"),
    ["l"] = tree_cb("edit"),
    ["o"] = tree_cb("edit"),
    ["<2-LeftMouse>"] = tree_cb("edit"),
    ["<2-RightMouse>"] = tree_cb("cd"),
    ["v"] = tree_cb("vslit"),
    ["s"] = tree_cb("split"),
    ["<C-t>"] = tree_cb("tabnew"),
    ["h"] = tree_cb("close-node"),
    ["<S-CR>"] = tree_cb("close_node"),
    ["<Tab>"] = tree_cb("preview"),
    ["I"] = tree_cb("toggle_ignored"),
    ["H"] = tree_cb("toggle_dotfiles"),
    ["R"] = tree_cb("refresh"),
    ["a"] = tree_cb("create"),
    ["d"] = tree_cb("remove"),
    ["r"] = tree_cb("rename"),
    ["<C-r>"] = tree_cb("full_name"),
    ["x"] = tree_cb("cut"),
    ["p"] = tree_cb("paste"),
    ["[c"] = tree_cb("prev_git_item"),
    ["]c"] = tree_cb("next_git_item"),
    ["-"] = tree_cb("dir_up"),
    ["q"] = tree_cb("close"),
}
vim.cmd([[source ~/.config/nvim/vimscript/nvimtree/nvimtree.vim]])
