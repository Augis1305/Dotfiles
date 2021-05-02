

" lsp provider to find the cursor word definition
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<cr>

" code action
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<cr>
vnoremap <silent><leader>ca <cmd>'<,'>lua require('lspsaga.codeaction').range_code_action()<cr>

" show documentation
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<cr>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>

" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with-saga(1)<cr>
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with-saga(-1)<cr>

" show signature help
nnoremap <silent>gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>

" Rename
nnoremap <silent><leader>gd <cmd>lua require('lspsaga.rename').rename()<cr>

" Show definition
nnoremap <silent><leader>pd <cmd>lua require('lspsaga.provider').preview_definition()<cr>
" nnoremap <silent><leader>pd <cmd>lua vim.lsp.buf.definition()<CR>

" Jump diagnostic
nnoremap <silent>[g <cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<cr>
nnoremap <silent>g] <cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<cr>
" nnoremap <<silent>g] <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <<silent>]g <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

