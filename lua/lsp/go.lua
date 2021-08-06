local on_attach = require'completion'.on_attach
local util = require'lspconfig/util'

require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    cmd = {"gopls", "--remote=auto"},
    filetypes = { "go", "gomod" },
    root_dir = util.root_pattern("go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}
