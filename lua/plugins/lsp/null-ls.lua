---@depracated replaced with conform
-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

-- for conciseness
local formatting = null_ls.builtins.formatting   -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
-- to setup format on savrstere
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
  -- setup formatters & linters
  sources = {
    --  to disable file types use
    --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
    formatting.prettier, -- js/ts formatter
    formatting.stylua,   -- lua formatter
    formatting.gofmt,
    formatting.gofumpt,
    formatting.goimports_reviser,
    formatting.golines,
    formatting.goimports,
    formatting.black.with({ extra_args = { "--fast" } }),
    formatting.isort,
    diagnostics.flake8,
    diagnostics.eslint_d,
  },
})
