local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local telescope_mapper = require("plugins.configs.mappings")

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  vim.keymap.set("n", "pd", "<cmd>Lspsaga peek_definition<CR>", opts)                -- see definition and make edits in window
  vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)        -- go to implementation
  vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)            -- see available code actions
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                 -- smart rename
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)   -- show  diagnostics for line
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  vim.keymap.set("n", "g[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)           -- jump to previous diagnostic in buffer
  vim.keymap.set("n", "g]", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)           -- jump to next diagnostic in buffer
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)                       -- show documentation for what is under cursor
  vim.keymap.set("n", "<leader><leader>f", vim.lsp.buf.format)

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)

  telescope_mapper("gr", "lsp_references", nil, true)
  telescope_mapper("gI", "lsp_implementations", nil, true)
  telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
  telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)
  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
vim.fn.sign_define("LspDiagnosticsSignError", { text = "", texthl = "LspDiagnosticsDefaultError" })
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

lspconfig["clangd"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure pyright server
lspconfig["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    analysis = {
      autoSearchPaths = true,
      diagnostics = "workspace",
      useLibraryCodeForTypes = true,
    },
  },
  single_file_support = true,
})

lspconfig["terraformls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- configure rust_analyzer server
lspconfig["rust_analyzer"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "rustup",
    "run",
    "stable",
    "rust-analyzer",
  },
})

-- configure gopls
lspconfig.gopls.setup({
  inlay_hints = { enabled = true },
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      } or nil,
    },
  },
})
--
-- configure lua server (with special settings)
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

require("sonarlint").setup({
  server = {
    cmd = {
      vim.fn.expand("$MASON/packages/sonarlint-language-server/sonarlint-language-server"),
      -- Ensure that sonarlint-language-server uses stdio channel
      "-stdio",
      "-analyzers",
      -- paths to the analyzers you need, using those for python and java in this example
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonargo.jar"),
    },
  },
  filetypes = {
    -- Tested and working
    "python",
    -- Requires nvim-jdtls, otherwise an error message will be printed
    "go",
    "ts",
    "js",
  },
})
