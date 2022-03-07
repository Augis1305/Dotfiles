local nvim_lsp = require("lspconfig")
local lsp_status = require("lsp-status")
local util = require("lspconfig/util")
local home = os.getenv("HOME")

local function noremap(type, input, output)
	vim.keymap.set(type, input, output, { noremap = true, silent = true })
end

local function nnoremap(input, output)
	noremap("n", input, output)
end
local function on_attach(client)
	lsp_status.on_attach(client)

	-- use omnifunc
	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	nnoremap("gd", vim.lsp.buf.definition)
	nnoremap("K", vim.lsp.buf.hover)
	nnoremap("gs", vim.lsp.buf.signature_help)
	nnoremap("gi", vim.lsp.buf.implementation)
	nnoremap("gt", vim.lsp.buf.type_definition)
	nnoremap("<leader>gw", vim.lsp.buf.document_symbol)
	nnoremap("<leader>gW", vim.lsp.buf.workspace_symbol)
	nnoremap("<leader>rr", vim.lsp.buf.rename)
	nnoremap("g[", vim.diagnostic.goto_prev)
	nnoremap("g]", vim.diagnostic.goto_next)
	nnoremap("<leader>ff", vim.lsp.buf.formatting)

	if client.name == "tsserver" or client.name == "html" or client.name == "lua" then
		client.resolved_capabilities.document_formatting = false
	end
end

lsp_status.register_progress()

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local sumneko_binary = home .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
	bashls = {},
	vimls = {},
	rust_analyzer = { filetype = { "rust" } },
	rls = { filetype = { "rust" } },
	jsonls = {},
	gopls = {
		cmd = { "gopls", "serve" },
		filetypes = { "go", "gomod" },
		rood_dit = util.root_pattern("go.mod", ".git"),
		codelens = { generate = true, gc_details = true },
		semanticTokens = true,
	},
	tsserver = {
		cmd = { "typescript-language-server", "--stdio" },
		rood_dit = function()
			return vim.fn.getcwd()
		end,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		capabilities = capabilities,
	},
	sumneko_lua = {
		cmd = {
			sumneko_binary,
			"-E",
			home .. "/.config/nvim/lua-language-server/main.lua",
		},
		filetypes = { "lua" },
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = {
						"vim",
						"vim.api",
						"nnoremap",
						"nmap",
						"inoremap",
						"vnoremap",
						"cnoremap",
						"Util",
					},
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
				},
			},
		},
	},
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = { debounce_text_changes = 50 },
	}, config)

	nvim_lsp[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end
