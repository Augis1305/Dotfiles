local nvim_lsp = require('lspconfig')
local util = require('lspconfig/util')
local home = os.getenv('HOME')
local rt = require('rust-tools')

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>gw', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', '<leader>gW', vim.lsp.buf.workspace_symbol, bufopts)
  vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader><leader>f', vim.lsp.buf.format)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>R', '<cmd>RustRun<cr>', bufopts)
  -- vim.keymap.set('n', '<leader>ca', rt.hover_actions.hover_actions, { buffer = bufnr })
  -- Code action groups
  vim.keymap.set('n', '<leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
  if client.name == 'tsserver' or client.name == 'html' or client.name == 'lua' then
    -- client.resolved_capabilities.document_formatting = false
    client.server_capabilities.documentFormattingProvider = false
  end
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local sumneko_binary = home .. '/.config/nvim/lua-language-server/bin/lua-language-server'
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local servers = {
  bashls = {},
  vimls = {},
  dockerls = {},
  yamlls = {},
  rust_analyzer = {
    filetypes = { 'rust' },
    cmd = { 'rustup', 'run', 'nightly', 'rust-analyzer' },
  },
  jsonls = { filetypes = { 'json', 'avsc' } },
  tsserver = {
    cmd = { 'typescript-language-server', '--stdio' },
    -- root_dir = function()
    --   return vim.fn.getcwd()
    -- end,
    -- filetypes = {
    --   'javascript',
    --   'javascriptreact',
    --   'javascript.jsx',
    --   'typescript',
    --   'typescriptreact',
    --   'typescript.tsx',
    -- },
    capabilities = capabilities,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
  html = { capabilities = capabilities },
  cssls = {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    root_dir = util.root_pattern('package.json') or vim.loop.os_homedir(),
    capabilities = capabilities,
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  },
  pylsp = {
    root_dir = function()
      return vim.fn.getcwd()
    end,
    init_options = { documentFormatting = false, codeAction = true },
  },
  gopls = {
    codelens = { generate = true, gc_details = true },
    experimentalWorkspaceModule = true,
    semanticTokens = true,
    experimentalPostfixCompletions = true,
    gofmt = true,
    staticcheck = true,
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
    --   hints": {
    --   "assignVariableTypes": true,
    --   "compositeLiteralFields": true,
    --   "constantValues": true,
    --   "functionTypeParameters": true,
    --   "parameterNames": true,
    --   "rangeVariableTypes": true
    -- },
  },
  pyright = {},
  clangd = {},
  sumneko_lua = {
    cmd = {
      sumneko_binary,
      '-E',
      home .. '/.config/nvim/lua-language-server/main.lua',
    },
    filetypes = { 'lua' },
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {
            'vim',
            'vim.api',
            'nnoremap',
            'nmap',
            'inoremap',
            'vnoremap',
            'cnoremap',
            'Util',
          },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },
  },
  zk = {
    filetypes = { 'markdown' },
  },
  terraform_lsp = {
    filetypes = { 'terraform', 'tf' },
  },
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= 'table' then
    config = {}
  end

  config = vim.tbl_deep_extend('force', {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = nil },
  }, config)

  nvim_lsp[server].setup(config)
end
local has_rust_tools = pcall(require, 'rust-tools')

if not has_rust_tools then
else
  rt.setup({
    tools = { -- rust-tools options
      autoSetHints = true,
      runnables = {
        use_telescope = true,
      },
      debuggables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = false,
        only_current_line = false,
        only_current_line_autocmd = 'CursorHold',
        show_parameter_hints = true,
        parameter_hints_prefix = '<- ',
        other_hints_prefix = '=> ',

        highlight = 'Comment',
      },
    },
    server = {
      capabilities = capabilities,
      on_attach = on_attach,

      flags = {
        debounce_text_changes = false,
      },

      settings = {
        ['rust-analyzer'] = {
          assist = {
            importGranularity = 'module',
            importPrefix = 'by_self',
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
        },
      },
    },
  })
end

for server, config in pairs(servers) do
  setup_server(server, config)
end
