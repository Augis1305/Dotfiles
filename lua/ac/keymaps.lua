M = {}

local Remap = require("configs.keymaps")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local cnoremap = Remap.cnoremap
local mapall = Remap.mapall
local nmap = Remap.nmap


inoremap("jk", "<esc>")
vnoremap("C-j", "<esc>")
vnoremap("C-c", "<esc>")

nnoremap("<leader>w", "<cmd>:w<cr>")
nnoremap("<leader>q", "<cmd>:q<cr>")

nnoremap("<leader>af", function()
  require("telescope.builtin").find_files()
end)

nnoremap("<C-f>", function()
  require("telescope.builtin").live_grep(require("telescope.themes").get_ivy())
end)

-- nnoremap("<C-p>", function()
--   require("telescope.builtin").git_files({ prompt_title = "Git files" })
-- end)

nnoremap("<leader>fs", function(input)
  vim.schedule(function()
    require("telescope.builtin").grep_string({ search = input, prompt_title = "Grep string" })
  end)
end)

-- Move lines up and down
nnoremap("<S-Up>", ":m-2<CR>")
nnoremap("<S-Down>", ":m+<CR>")
inoremap("<S-Up>", "<Esc>:m-2<CR>")
inoremap("<S-Down>", "<Esc>:m+<CR>")

-- Other stuff
nnoremap("<leader>h", ":nohls<cr>")
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")
nnoremap("g*", "g*zz")
nnoremap("?", "?\\v")
nnoremap("/", "/\\v")
cnoremap("%s/", "%sm/")

mapall("H", "^")
mapall("L", "$")
nnoremap("j", "jzz")
nnoremap("k", "kzz")

nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

nnoremap("<Left>", "<cmd>vertical resize +2<cr>")
nnoremap("<Right>", "<cmd>vertical resize -2<cr>")
nnoremap("<Up>", "<cmd>resize +2<cr>")
nnoremap("<Down>", "<cmd>resize -2<cr>")
nnoremap("gx", "<cmd>lua Util.xdg_open()<cr>", { silent = true })
nnoremap("<leader>rg", "<cmd>source<cr>", { silent = true })
nmap("<C-t>", ":vsplit | term<CR>")

-- Move to previous/next
nnoremap('<A-,>', '<Cmd>BufferPrevious<CR>')
nnoremap('<A-.>', '<Cmd>BufferNext<CR>')
-- Re-order to previous/next
--
-- nnoremap('<A-<>', '<Cmd>BufferMovePrevious<CR>')
-- nnoremap('<A->>', '<Cmd>BufferMoveNext<CR>')
-- Goto buffer in position...
nnoremap('<A-1>', '<Cmd>BufferGoto 1<CR>')
nnoremap('<A-2>', '<Cmd>BufferGoto 2<CR>')
nnoremap('<A-3>', '<Cmd>BufferGoto 3<CR>')
nnoremap('<A-4>', '<Cmd>BufferGoto 4<CR>')
nnoremap('<A-5>', '<Cmd>BufferGoto 5<CR>')
nnoremap('<A-6>', '<Cmd>BufferGoto 6<CR>')
nnoremap('<A-7>', '<Cmd>BufferGoto 7<CR>')
nnoremap('<A-8>', '<Cmd>BufferGoto 8<CR>')
nnoremap('<A-9>', '<Cmd>BufferGoto 9<CR>')
nnoremap('<A-0>', '<Cmd>BufferLast<CR>')
-- Pin/unpin buffer
nnoremap('<leader>bp', '<Cmd>BufferPin<CR>')
-- Close buffer
nnoremap('<leader>cb', '<Cmd>BufferClose<CR>', opts)
nnoremap('<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
nnoremap('<Space>bd', '<Cmd>BufferOrderByDirectory<CR>')
nnoremap('<Space>bl', '<Cmd>BufferOrderByLanguage<CR>')
nnoremap('<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>')

nnoremap("<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>")
nnoremap("<leader>td", "<cmd>Trouble document_diagnostics<cr>")
nnoremap("<leader>tl", "<cmd>Trouble loclist<cr>")
nnoremap("<leader>tq", "<cmd>Trouble quickfix<cr>")
nnoremap("<leader>tx", "<cmd>TroubleClose<cr>")

inoremap("<C-BS>", "<Esc>cvb")


