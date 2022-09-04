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
  vim.keymap.set('n', '<leader>ca', rt.hover_actions.hover_actions, { buffer = bufnr })
  -- Code action groups
  vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
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
  -- rls = { filetypes = { 'rust' } },
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
    filetypes = { 'terraform', 'tf' },
  },
}

local opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools/executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = " <- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = " => ",

      -- whether to align to the length of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
    },
  },
}

rt.setup(opts)

-- require('rust-tools').inlay_hints.enable()

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

for server, config in pairs(servers) do
  setup_server(server, config)
end
