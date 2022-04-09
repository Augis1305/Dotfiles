require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.diagnostics.eslint,

		-- require("null-ls").builtins.diagnostics.golangci_lint,
		require("null-ls").builtins.formatting.golines,

		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.hover.dictionary,
	},
})
