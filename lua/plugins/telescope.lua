return {
  {
    "nvim-telescope/telescope.nvim",
    priority = 100,
    dependencies = {
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      require("plugins.configs.telescope")
      require("plugins.configs.keys")
    end,
  },
}
