local colors = {
  none = "NONE",
  bg = "#202328",
  bg_test = "#24283b",
  night_bg = "#1a1b26",
  fg = "#bbc2cf",
  bg_float = "#16161E",
  bg_dark = "#1f2335",
  fg_dark = "#A9B1D6",
  dark5 = "#737aa2",
  cursor_fg = "#415062",
  cursor_bg = "#AbAbAf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  purple = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  terminal_black = "#414868",
  blue0 = "#3d59a1",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  magenta2 = "#ff007c",
  teal = "#1abc9c",
  red1 = "#db4b4b",
  fg_gutter = "#3b4261",
  dark3 = "#545c7e",
  comment = "#565f89",
  black = "#000000",
  bg_statusline = "#16161E",
  fg_sidebar = "#A9B1D6",
  virtual_err = "#2D202A",
  virtual_info = "#192B38",
  virtual_warn = "#2E2A2D",
  virtual_hint = "#2E2A2D",
}

local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- local null_ls = require("null-ls")
-- local colors = require "user.highlights.palette"

local mode_names = {
  ["n"] = "NORMAL",
  ["no"] = "PENDING",
  ["nov"] = "PENDING",
  ["noV"] = "PENDING",
  ["no\22"] = "PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["ntT"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local mode = {
  function()
    local mode_name = vim.api.nvim_get_mode().mode
    if mode_names[mode_name] == nil then
      return mode_name
    end
    return mode_names[mode_name]
  end,
  color = function()
    local mode_color = {
      n = colors.blue,
      no = colors.blue,
      nov = colors.blue,
      noV = colors.blue,
      ["no\22"] = colors.blue,
      niI = colors.blue,
      niR = colors.blue,
      ntT = colors.blue,
      nt = colors.blue,
      i = colors.green,
      ic = colors.yellow,
      ix = colors.green,
      v = colors.purple,
      vs = colors.purple,
      Vs = colors.purple,
      [""] = colors.purple,
      ["\22s"] = colors.purple,
      V = colors.purple,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      R = colors.red,
      Rc = colors.red,
      Rv = colors.red,
      Rx = colors.red,
      Rvc = colors.red,
      Rvx = colors.red,
      c = colors.yellow,
      cv = colors.blue,
      ce = colors.blue,
      r = colors.red,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.blue,
      t = colors.blue,
    }
    return { fg = mode_color[vim.api.nvim_get_mode().mode], bg = "#252F3D" }
  end,
  separator = { right = "" },
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "hint" },
  symbols = { error = "  ", warn = "  ", hint = " " },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    hint = { fg = colors.violet },
  },
  update_in_insert = false,
  always_visible = true,
  color = { bg = colors.bg },
  separator = { right = "" },
}

local diff = {
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.blue },
    removed = { fg = colors.red },
  },
  cond = hide_in_width,
  color = { bg = colors.bg },
  separator = { left = "" },
}

local branch = {
  "branch",
  icons_enabled = true,
  color = { fg = colors.fg, bg = "gray15" },
  icon = " ",
  separator = { right = "" },
}

local filesize = {
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)
      if size <= 0 then
        return ""
      end
      local sufixes = { " B", " KB", " MB", " GB" }
      local i = 1
      while size > 1024 do
        size = size / 1024
        i = i + 1
      end
      return string.format("%.1f%s", size, sufixes[i])
    end

    local file = vim.fn.expand("%:p")
    if string.len(file) == 0 then
      return ""
    end
    return format_file_size(file)
  end,
  color = { fg = colors.green, bg = "gray15" },
  separator = { left = "" },
}

local lsp = {
  function()
    -- local buf_clients = vim.lsp.buf_get_clients()
    local buf_clients = vim.lsp.client()
    local clients = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(clients, client.name)
      end
    end

    -- local supported_formatters = null_ls.list_registered_formatters(vim.bo.filetype)
    -- vim.list_extend(clients, supported_formatters)

    if #clients > 0 then
      return table.concat(clients, ", ")
    else
      return "LS Inactive"
    end
  end,
  -- icon = "\ :",
  color = { fg = colors.fg, gui = "", bg = colors.bg },
  separator = { left = "", right = "" },
}

-- cool function for progress
local progress = {
  function()
    local current_line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  color = { fg = colors.fg, bg = colors.bg },
}

local percent = {
  "progress",
  separator = { left = "" },
  color = { fg = colors.fg, bg = "gray22" },
}

local spaces = {
  function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  color = { fg = colors.yellow, bg = "gray18" },
  separator = { left = "" },
}
local filetype = {
  "filetype",
  color = { fg = colors.fg, bg = colors.bg },
  separator = { left = "" },
  pading = 0,
}

lualine.setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    disabled_filetypes = {
      "dashboard",
      "lspinfo",
      "mason",
      "startuptime",
      "checkhealth",
      "help",
      "TelescopePrompt",
      "toggleterm",
    },
    always_divide_middle = true,
  },

  sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = { branch, mode, diagnostics, "%=", lsp },
    lualine_x = { diff, filetype, spaces, filesize, percent, progress },
    lualine_y = {},
    lualine_z = {},
  },
})



