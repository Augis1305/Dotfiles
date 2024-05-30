local config = {
  virtual_text = true,
  update_in_insert = true,
  upderline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "gopls",
    "dockerls",
    "lua_ls",
    "rust_analyzer",
    "jsonls",
    "pyright",
  },
  automatic_installation = true,
  run_on_start = true,
})

-- require("mason-null-ls").setup({
--   -- list of formatters & linters for mason to install
--   ensure_installed = {
--     "prettier", -- ts/js formatter
--     "stylua",   -- lua formatter
--     "eslint_d", -- ts/js linter
--     "pylint",   -- ts/js linter
--     "black",
--     "flake8",
--     "isort",
--     "sonarling-language-server"
--   },
--   -- auto-install configured formatters & linters (with null-ls)
--   automatic_installation = true,
-- })
