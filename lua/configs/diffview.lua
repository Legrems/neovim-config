return {
  hooks = {
    diff_buf_read = function(_)
      vim.opt_local.wrap = false
      vim.opt_local.list = false
    end,
    view_opened = function(_)
      vim.api.nvim_command "set ft=diff"
    end,
  },
}
