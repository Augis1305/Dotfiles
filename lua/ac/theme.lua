-- require("github-theme").setup({
-- 	theme_style = "dark_default",
-- 	comment_style = "italic",
-- })

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- vim.api.nvim_command [[ colorscheme tokyonight]]
-- vim.api.nvim_command [[ colorscheme catppuccin]]
vim.cmd[[colorscheme catppuccin]]
