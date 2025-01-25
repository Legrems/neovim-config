-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "onedark",
  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  theme = "onedark",
  tabufline = {
    enabled = false,
    -- order = { "tabs", "buffers" },
  },
  statusline = {
    theme = "default",
    separator_style = "arrow",
    order = {
      "macro",
      "mode",
      "relativepath",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
    },
    modules = {
      macro = function()
        local noice = require "noice"
        if noice.api.statusline.mode.has() then
          return "%#St_CommandMode#" .. noice.api.statusline.mode.get()
        end
        return ""
      end,
      relativepath = function()
        local stbufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
        local path = vim.api.nvim_buf_get_name(stbufnr)

        if path == "" then
          return ""
        end

        return "%#St_file#  " .. vim.fn.expand "%:.:h" .. " /"
      end,
    },
  },
}

return M
