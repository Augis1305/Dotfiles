local function modify_mode_text(mode)
	local instructions = {
		["NORMAL"] = "N",
		["INSERT"] = "I",
		["VISUAL"] = "V",
		["V-LINE"] = "VL",
		["V-BLOCK"] = "VB",
		["SELECT"] = "S",
		["S-LINE"] = "SL",
		["S-BLOCK"] = "SB",
		["REPLACE"] = "R",
		["V-REPLACE"] = "VR",
		["COMMAND"] = "C",
		["EX"] = "E",
		["MORE"] = "M",
		["TERMINAL"] = "T",
	}
	return instructions[mode]
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = "gruvbox_dark",
		theme = "catppuccin",
		-- theme = "tokyonight",
		section_separators = { "", "" },
		component_separators = { "", "" },
		disabled_filetypes = {},
		padding = 1,
        globalstatus = true,
	},
	sections = {
		-- lualine_a = { { "mode", fmt = modify_mode_text } },
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = {
			{ "filename", file_status = true, path = 1 },
		},
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				sections = { "error", "warn", "info", "hint" },
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "encoding", "fileformat", "filetype" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "fugitive", "quickfix" },
})
