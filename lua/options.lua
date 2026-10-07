require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt
local g = vim.g

------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false
opt.relativenumber = true

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.scrolloff = 15

opt.wildignore:append "tags,Session.vim"

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
-- autocmd("FileType", {
--   pattern = "qf",
--   callback = function()
--     vim.opt_local.buflisted = false
--   end,
-- })
autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.fs.normalize(ev.file))
    if ok and stats and stats.size < max_filesize then
      pcall(vim.treesitter.start, ev.buf)
      vim.bo[ev.buf].syntax = "on" -- Use regex based syntax-highlighting as fallback as some plugins might need it
      vim.wo.foldlevel = 99
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for folds
      -- vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- Temporarily disable treesitter indentation
      vim.bo[ev.buf].autoindent = true -- Enable basic autoindent
    end
  end,
})

-- fugitive: <CR> on a commit opens it in diffview, fallback to fugitive's <CR> otherwise
autocmd("FileType", {
  pattern = { "fugitive", "git" },
  callback = function(ev)
    -- scheduled so fugitive has set its own buffer mappings first
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(ev.buf) then
        return
      end
      local orig = vim.fn.maparg("<CR>", "n", false, true)
      if orig.desc == "Diffview commit" then
        return
      end
      vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_get_current_line()
        local hash = line:match "^commit (%x+)" or line:match "^(%x%x%x%x%x%x%x+)%s"
        if hash then
          return "<cmd>DiffviewOpen " .. hash .. "^!<CR>"
        end
        return orig.rhs or "<CR>"
      end, { buffer = ev.buf, expr = true, silent = true, desc = "Diffview commit" })
    end)
  end,
})
