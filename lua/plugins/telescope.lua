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
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = " ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
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

