return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.configs.statusline")
    end,
  },
}
