require('gitsigns').setup {
    signs = {
        add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
        change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    numhl = false,
    keymaps = {
        noremap = true,
        buffer = true,
        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},
        ['n <leader>ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ['n <leader>ghu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>ghb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',
    },
    watch_gitdir= {
        interval = 700
    },
    sign_priority = 6,
    status_formatter = nil,
}
