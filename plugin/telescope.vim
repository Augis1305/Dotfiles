lua << EOF
require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_position = "bottom",
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = " ",
		initial_mode = "normal",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_defaults = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirrot = false,
			},
		},
		file_sorter = require'telescope.sorters'.get_fzy_sorter,
		file_ignore_patterns = {},
		shorter_path = true,
		winblend = 0,
		width = 0.75,
		preview_cutoff = 120,
		results_height = 1,
		results_width = 0.8,
		border = {},
		color_devicons = true,
		use_less = true,
		set_env = { ['COLORTERM'] = 'truecolor' }, --default = nil,
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}
	}
}
require('telescope').load_extension('fzy_native')

EOF

nnoremap <C-p> :lua require('telescope.builtin').git_files()<cr>
nnoremap <Leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <Leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <Leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <Leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <Leader>fr <cmd>lua require('telescope.builtin').registers()<cr>

nnoremap <Leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <Leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>


