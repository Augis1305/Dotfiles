local null_ls = require('null-ls')
local b = null_ls.builtins

local starts_with = function(str, start)
  return string.sub(str, 1, #start) == start
end

local create_runtime_condition = function(config_names)
  local bufnr_cache = {}
  local config_path_cache = {}

  return function(params)
    if bufnr_cache[params.bufnr] ~= nil then
      return bufnr_cache[params.bufnr]
    else
      for _, cached_config_path in ipairs(config_path_cache) do
        if starts_with(params.bufname, cached_config_path) then
          bufnr_cache[params.bufnr] = true
          return true
        end
      end
    end

    local config_path = require('lspconfig').util.root_pattern(config_names)(params.bufname)

    local has_config = config_path ~= nil
    if has_config then
      table.insert(config_path_cache, config_path)
    end
    bufnr_cache[params.bufnr] = has_config

    return has_config
  end
end

local eslint_runtime_condition = create_runtime_condition({
  '.eslintrc.cjs',
  '.eslintrc.js',
  '.eslintrc.json',
  '.eslintrc.yaml',
  '.eslintrc.yml',
})

local stylua_runtime_condition = create_runtime_condition({ 'stylua.toml', '.stylua.toml' })

local prettier_runtime_condition = create_runtime_condition({ '.prettierrc', '.prettierrc.json' , 'prettier.config.js'})

null_ls.setup({
  diagnostics_format = '[#{c}] #{m} (#{s})',
  sources = {
    -- Lua
    b.formatting.stylua.with({ runtime_condition = stylua_runtime_condition }),

    -- b.formatting.prettier.with({ runtime_condition = prettier_runtime_condition }),

    b.formatting.prettierd.with(
      { extra_filetypes = { 'scss', 'css', 'html' } },
      { runtime_condition = prettier_runtime_condition }
    ),

    b.formatting.gofmt,

    -- b.code_actions.eslint,
    -- b.formatting.eslint.with 

    -- b.diagnostics.eslint.with({ runtime_condition = eslint_runtime_condition }),
    -- b.formatting.eslint,
    -- b.code_actions.eslint,


    -- Git
    b.code_actions.gitsigns,

    -- Spelling
    b.completion.spell,
    b.hover.dictionary,

    -- Shell
    b.diagnostics.shellcheck,
    b.code_actions.shellcheck,

  },
})
