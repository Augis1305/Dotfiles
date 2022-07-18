local actions = require("telescope.actions")
local telescope = require("telescope")
-- Global remapping

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    prompt_prefix = ">",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "flex",
    layout_config = { vertical = { width = 0.75 } },
    mappings = {
      i = {
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,
      },
    },
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    file_ignore_patterns = { "yarn.lock", "package-lock" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = {
      { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    color_devicons = true,
    use_less = false,
    scroll_strategy = "cycle",
    set_env = { ["COLORTERM"] = "truecolor" }, -- default { }, currently unsupported for shells like cmd.exe / powershell.exe
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      ignore_current_buffer = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = { ["<C-d>"] = actions.delete_buffer },
        n = { ["<C-d>"] = actions.delete_buffer },
      },
    },
    git_files = {
      theme = "ivy",
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
