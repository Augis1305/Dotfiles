nnoremap <C-p> :lua require('telescope.builtin').git_files()<cr>
nnoremap <Leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <Leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <Leader>fr <cmd>lua require('telescope.builtin').registers()<cr>

nnoremap <Leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <Leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>

nnoremap <Leader>d <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>

