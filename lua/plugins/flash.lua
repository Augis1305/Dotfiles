-- return {
--   {
--     "folke/flash.nvim",
--     event = "VeryLazy",
--     ---@type Flash.Config
--     -- opts = {},
--     keys = {
--       {
--         "s",
--         mode = { "n", "x", "o" },
--         function()
--           require("flash").jump({
--             search = {
--               mode = function(str)
--                 return "\\<" .. str
--               end,
--             },
--           })
--         end,
--         desc = "Flash",
--       },
--       {
--         "S-S",
--         mode = { "n", "o", "x" },
--         function()
--           require("flash").treesitter()
--         end,
--         desc = "Flash Treesitter",
--       },
--       {
--         "r",
--         mode = "o",
--         function()
--           require("flash").remote()
--         end,
--         desc = "Remote Flash",
--       },
--       {
--         "R",
--         mode = { "o", "x" },
--         function()
--           require("flash").treesitter_search()
--         end,
--         desc = "Flash Treesitter Search",
--       },
--       {
--         "<c-s>",
--         mode = { "c" },
--         function()
--           require("flash").toggle()
--         end,
--         desc = "Toggle Flash Search",
--       },
--     },
--   },
-- }

return {
  {
    "folke/flash.nvim",
    enabled = true,
    build = function() end,
    init = function()
      -- vim.opt.keymap = "emoji"
    end,
    ---@type Flash.Config
    opts = {
      -- labels = "#abcdef",
      label = {
        -- format = function(opts)
        --   return { { opts.match.label:upper(), opts.hl_group } }
        -- end,
      },
      modes = {
        -- treesitter = {
        --   label = {
        --     rainbow = { enabled = true },
        --   },
        -- },
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
            -- format = function(opts)
            --   local label = opts.match.label
            --   if opts.after then
            --     label = label .. ">"
            --   else
            --     label = "<" .. label
            --   end
            --   return { { label, opts.hl_group } }
            -- end,
          },
        },
      },
      -- search = { mode = "fuzzy" },
      -- labels = "😅😀🏇🐎🐴🐵🐒",
    },
  },
}
