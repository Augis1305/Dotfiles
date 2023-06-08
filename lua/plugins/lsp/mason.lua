local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
  return
end

local lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not lsp_status_ok then
  return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  return
end

local config = {
  virtual_text = false,
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
mason.setup()

mason_lsp.setup({
  ensure_installed = {
    "clangd",
    "gopls",
    "dockerls",
    "lua_ls",
    "rust_analyzer",
    "jsonls",
    "tsserver",
  },

  automatic_installation = true,
})

mason_null_ls.setup({
  -- list of formatters & linters for mason to install
  ensure_installed = {
    "prettier", -- ts/js formatter
    "stylua", -- lua formatter
    "eslint_d", -- ts/js linter
    "pylint", -- ts/js linter
    "black",
    "flake8",
    "isort",
  },
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
})
