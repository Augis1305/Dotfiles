-- return {
--   "mfussenegger/nvim-dap",
--   "rcarriga/nvim-dap-ui",
--   "theHamsta/nvim-dap-virtual-text",
--   "nvim-telescope/telescope-dap.nvim",
--
--   --  Adaparter configuration for specific languages
--   { "leoluz/nvim-dap-go" },
-- }

return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "leoluz/nvim-dap-go",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
}
