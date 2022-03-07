local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
	if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
		return
	end

	local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

	vim.fn.mkdir(directory, "p")

	local out = vim.fn.system(
		string.format("git clone %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
	)

	print(out)
	print("Downloading packer.nvim...")

	return
end

return require("packer").startup({
	function(use)
		use({ "wbthomason/packer.nvim", opt = true })

		use("windwp/nvim-autopairs")
		use("numToStr/Comment.nvim")

		-- Navigation
		use("kyazdani42/nvim-tree.lua")

		-- Theme
		use("kyazdani42/nvim-web-devicons")
		use("gruvbox-community/gruvbox")
		use("nvim-treesitter/nvim-treesitter")
		use("ghifarit53/tokyonight-vim")
		use("projekt0n/github-nvim-theme")
		use("jose-elias-alvarez/null-ls.nvim")

		-- Lsp
		use("neovim/nvim-lspconfig")
		use("nvim-lua/lsp-status.nvim")
		use("norcalli/nvim-colorizer.lua")
		use("RishabhRD/popfix")
		use("RishabhRD/nvim-lsputils")
		use("L3MON4D3/LuaSnip") -- Snippets plugin
		use("rafamadriz/friendly-snippets")

		-- nvim-cmp
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/vim-vsnip",
				"hrsh7th/vim-vsnip-integ",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-vsnip",
				"saadparwaiz1/cmp_luasnip",
			},
		})
		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		})

		use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		-- Git
		use("lewis6991/gitsigns.nvim")
		use("tpope/vim-fugitive")
		use("sindrets/diffview.nvim")

		-- zk
		use("mickael-menu/zk-nvim")

		-- Float term
		use("voldikss/vim-floaterm")
	end,
})
