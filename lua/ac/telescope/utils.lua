local M = {}

local telescope_utils = require("telescope.utils")

local use_git_root = true

local get_filename = function()
	return vim.fn.expand("%:t")
end

local get_git_root = function()
	local git_root, ret = telescope_utils.get_os_command_output({
		"git",
		"rev-parse",
		"--show-toplevel",
	}, vim.loop.cwd())
	if ret ~= 0 then
		return vim.loop.cwd()
	end

	return git_root[1]
end

local get_root = function()
	local root = get_git_root()
	if not use_git_root then
		vim.loop.cwd()
	end
	return root
end

local root_name = function()
	local root = get_root()
	return root, string.upper(vim.fn.fnamemodify(root, ":t"))
end

M.find_files = function()
	local _ = root_name()
	require("telescope.builtin").find_files({ prompt_title = "Find files" })
end

M.live_grep = function()
	local root = root_name()
	require("telescope.builtin").live_grep({ cwd = root, prompt_title = "Live grep" })
end

M.grep_string = function(input)
	local root = root_name()
	vim.schedule(function()
		require("telescope.builtin").grep_string({ cwd = root, search = input, prompt_title = "Grep string" })
	end)
end

M.buffers = function()
	require("telescope.builtin").buffers({ prompt_title = "Buffers" })
end

M.lsp_references = function()
	local reference_word = "References for: " .. string.upper(vim.fn.expand("<cword>"))
	require("telescope.builtin").lsp_references({ prompt_title = reference_word })
end

M.git_files = function()
	require("telescope.builtin").git_files({ prompt_title = "Git files" })
end

return M
