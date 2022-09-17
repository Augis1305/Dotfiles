require("lsp-inlayhints").setup({
  inlay_hints = {
    parameter_hints = {
      show = true,
      prefix = " <- ",
      separator = ", ",
      remove_colon_start = true,
      remove_colon_end = true,
    },
    -- type and other hints
    type_hints = {
      show = true,
      prefix = " => ",
      separator = ", ",
      remove_colon_start = true,
      remove_colon_end = true,
    },
    only_current_line = false,
    -- separator between types and parameter hints. Note that type hints are shown before parameter
    labels_separator = "  ",
    -- whether to align to the length of the longest line in the file
    max_len_align = false,
    -- padding from the left if max_len_align is true
    max_len_align_padding = 1,
    -- highlight group
    highlight = "SignColumn",
  },
})

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})