return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup({})

      vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>")
      vim.keymap.set("n", "<leader>hv", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
    end,
  },
}
