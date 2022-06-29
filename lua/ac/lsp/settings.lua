local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')
local util = require('lspconfig/util')
local home = os.getenv('HOME')
local utils = require('ac.telescope.utils')

local function mapping(client)
  nnoremap('gd', vim.lsp.buf.definition)
  nnoremap('K', vim.lsp.buf.hover)
  nnoremap('gs', vim.lsp.buf.signature_help)
  nnoremap('gi', vim.lsp.buf.implementation)
  nnoremap('gt', vim.lsp.buf.type_definition)
  nnoremap('<leader>gw', vim.lsp.buf.document_symbol)
  nnoremap('<leader>gW', vim.lsp.buf.workspace_symbol)
  nnoremap('<leader>rr', vim.lsp.buf.rename)
  nnoremap('g[', vim.diagnostic.goto_prev)
  nnoremap('g]', vim.diagnostic.goto_next)
  nnoremap('<leader>ff', vim.lsp.buf.format { async = true })

  -- local buf_name = vim.fn.expand('%s')
  -- if string.find(buf_name, 'NvimTree*') == nil and client ~= nil then
  --   vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
  --   -- if client.resolved_capabilities.document_highlight then
  --   if client.server_capabilities.documentHighlightProvider then
  --     vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
  --   end
  --   -- if client.resolved_capabilities.code_lens then
  --   if client.server_capabilities.code_lens then
  --     vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
  --   end
  -- end
end

local function on_attach(client)
  lsp_status.on_attach(client)

  -- use omnifunc
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  mapping(client)

  if client.name == 'tsserver' or client.name == 'html' or client.name == 'lua' then
    -- client.resolved_capabilities.document_formatting = false
    client.server_capabilities.documentFormattingProvider = false
  end
end

lsp_status.register_progress()

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local sumneko_binary = home .. "/.config/nvim/lua-language-server/bin/lua-language-server"
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
  rust_analyzer = { filetypes = { 'rust' } },
  rls = { filetypes = { 'rust' } },
  jsonls = { filetypes = { 'json', 'avsc' } },
  tsserver = {
    cmd = { 'typescript-language-server', '--stdio' },
    root_dir = function()
      return vim.fn.getcwd()
    end,
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    capabilities = capabilities,
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
    filetypes = { 'terraform', 'tf' }
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
    flags = { debounce_text_changes = 50 },
  }, config)

  nvim_lsp[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

local lsp_group = vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = lsp_group,
})
