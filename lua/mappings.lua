-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         CORE MAPPINGS                           │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

local map = vim.keymap.set

-- Leader is <Space>

-- jk to exit insert mode
map("i", "jk", "<ESC>")

-- Remap ; to : for command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Clear search highlights
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })

-- Reload config
map("n", "<leader>rr", ":source $MYVIMRC<CR>", { desc = "Reload config file" })

-- Save & Quit
map("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
map("n", "<C-q>", "<cmd> q! <CR>", { desc = "Force quit window" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         WINDOW & TAB MANAGEMENT                 │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- Switch between windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- Window manipulation (winshift)
map("n", "<leader>ww", require("nvim-window").pick, { desc = "[W]indow Pick" })
map("n", "<leader>wm", ":WinShift<CR>", { desc = "[W]indow [M]ove mode" })
map("n", "<leader>ws", ":WinShift swap<CR>", { desc = "[W]indow [S]wap" })

-- Tab management
map("n", "<F1>", "<cmd> tabprevious<CR>", { desc = "Previous tab" })
map("n", "<F2>", "<cmd> tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "[T]ab [C]lose" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         EDITING & MOVEMENT                      │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- Insert mode navigation
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

-- New lines
map("n", "<Return>", "o<ESC>", { desc = "Insert new line below" })
map("n", "<BS>", "O<ESC>", { desc = "Insert new line above" })

-- Indentation in visual mode
map("v", "<", "<gv", { desc = "Indent line" })
map("v", ">", ">gv", { desc = "Indent line" })

-- Centered movement
map("n", "n", "nzz", { desc = "Next search + center" })
map("n", "N", "Nzz", { desc = "Previous search + center" })
map("n", "(", "(zz", { desc = "Previous sentence + center" })
map("n", ")", ")zz", { desc = "Next sentence + center" })
map("n", "{", "{zz", { desc = "Previous paragraph + center" })
map("n", "}", "}zz", { desc = "Next paragraph + center" })
map("n", "[[", "[[zz", { desc = "Previous function + center" })
map("n", "]]", "]]zz", { desc = "Next function + center" })

-- Go to next/previous uppercase letter
map("n", "gf", ":call search('[A-Z]', 'W')<CR>", { desc = "[G]o [F]orward to uppercase" })
map("n", "fg", ":call search('[A-Z]', 'bW')<CR>", { desc = "[F]ind [G]one (previous) uppercase" })

-- Delete line from start
map("n", "<leader>dl", "0d$", { desc = "[D]elete [L]ine" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         REGISTERS & YANK/PASTE                  │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- Don't copy replaced text after pasting in visual mode
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Paste without yanking replaced text" })

-- Override all delete/yank/paste to use the 'M' register by default
map({ "n", "v" }, "y", '"my', { desc = "Yank to 'm' register", remap = false })
map({ "n", "v" }, "p", '"mp', { desc = "Paste from 'm' register", remap = false })
map({ "n", "v" }, "d", '"md', { desc = "Delete to 'm' register", remap = false })

-- Yank/Paste to/from system clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "[P]aste from system clipboard" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         PLUGIN: TELESCOPE                       │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

local telescope = require "telescope.builtin"

map("n", "<leader>;", "<cmd> Telescope <CR>", { desc = "Open Telescope" })
map("n", "<A-f>", telescope.resume, { desc = "Telescope Resume" })
map("n", "<A-k>", telescope.keymaps, { desc = "Telescope Keymaps" })

-- Finders
map("n", "<C-g>", telescope.find_files, { desc = "Find files" })
map("n", "<C-x>", function()
  telescope.find_files { follow = true, no_ignore = true, hidden = true }
end, { desc = "Find all files (incl. hidden)" })
map("n", "<C-b>", telescope.buffers, { desc = "Find buffers" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "[F]ind [O]ldfiles" })
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "[F]ind [H]elp" })
map("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "[M]arks" })
map("n", "<leader>wl", "<cmd> Telescope workspaces <CR>", { desc = "[W]orkspace [L]ist" })
map("n", "<leader>ch", "<cmd> Telescope command_history <CR>", { desc = "[C]ommand [H]istory" })
map("n", "<leader>/", "<cmd> Telescope search_history <CR>", { desc = "Search History" })

-- Live Grep (Find in Files)
map("n", "<C-f>", telescope.live_grep, { desc = "Live grep" })
map("n", "<leader>fg<CR>", function()
  telescope.live_grep {}
end, { desc = "[F]ind by [G]rep" })

map("n", "<leader>fg/", function()
  telescope.live_grep { default_text = vim.fn.getreg "/" }
end, { desc = "[F]ind by [G]rep with search term" })

map("n", "<leader>fgw", function()
  telescope.live_grep { default_text = vim.fn.expand "<cword>" }
end, { desc = "[F]ind by [G]rep with [W]ord" })

map("n", "<leader>ff", function()
  telescope.live_grep { default_text = "<<<<<<< HEAD" }
end, { desc = "[F]ind Git Con[f]licts" })

-- Find Files (Find in Project)
map("n", "<leader>gf<CR>", function()
  telescope.find_files {}
end, { desc = "[G]it [F]iles" })

map("n", "<leader>gf/", function()
  telescope.find_files { default_text = vim.fn.getreg "/" }
end, { desc = "[G]it [F]iles with search term" })

map("n", "<leader>gfw", function()
  telescope.find_files { default_text = vim.fn.expand "<cword>" }
end, { desc = "[G]it [F]iles with [W]ord" })

-- Buffer Fuzzy Find
map("n", "<leader>fx<CR>", function()
  telescope.current_buffer_fuzzy_find {}
end, { desc = "[F]uzzy find in current buffer" })

map("n", "<leader>fx/", function()
  telescope.current_buffer_fuzzy_find { default_text = vim.fn.getreg "/" }
end, { desc = "[F]uzzy find with search term" })

map("n", "<leader>fxw", function()
  telescope.current_buffer_fuzzy_find { default_text = vim.fn.expand "<cword>" }
end, { desc = "[F]uzzy find with [W]ord" })

-- Custom Pickers
map("n", "<leader>gm", function()
  require("configs.telescope.custom").cpickers()
end, { desc = "[G]eneral [M]enus (custom)" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         PLUGIN: LSP & DIAGNOSTICS               │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- LSP Actions
map("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, { desc = "[F]ormat file" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
map("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "[L]SP [S]ignature Help" })

-- LSP Goto
map("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
-- map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" }) -- Default K is used by Noice
map("n", "gi", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })
map("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })

-- Diagnostics
map("n", "<leader>lf", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "[L]SP [F]loating diagnostic" })
map("n", "[d", function()
  vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, { desc = "Previous [D]iagnostic" })
map("n", "]d", function()
  vim.diagnostic.goto_next { float = { border = "rounded" } }
end, { desc = "Next [D]iagnostic" })
map("n", "gK", function()
  vim.diagnostic.config { virtual_lines = not vim.diagnostic.config().virtual_lines }
end, { desc = "Toggle virtual lines diagnostic" })

-- Workspace
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[W]orkspace [R]emove folder" })
map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "[W]orkspace [L]ist folders" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         PLUGIN: GIT                             │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- Fugitive
map("n", "<C-c>", "<cmd> vertical topleft Git <bar> vertical resize 50<CR>", { desc = "Git status" })

-- Diffview
map("n", "<C-d>", "<cmd> DiffviewOpen -- %<CR>", { desc = "Diff current file" })
map("n", "<C-a-d>", "<cmd> DiffviewClose<CR>", { desc = "Close git diff" })
map("n", "<C-p>", "<cmd> DiffviewOpen<CR>", { desc = "Diff all" })
map("n", "<a-p>", ":DiffviewOpen HEAD~", { desc = "Diff last N commits" })
map("n", "<leader>gd", "<cmd> DiffviewClose<CR>", { desc = "[G]it [D]iff Close" })

-- Gitsigns
local gitsigns = require "gitsigns"
map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk "next"
  end
end, { desc = "Next hunk" })
map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.nav_hunk "prev"
  end
end, { desc = "Previous hunk" })
map("n", "<leader>rh", gitsigns.reset_hunk, { desc = "[R]eset [H]unk" })
map("n", "<leader>ph", gitsigns.preview_hunk, { desc = "[P]review [H]unk" })
map("n", "<leader>bb", gitsigns.blame_line, { desc = "[B]lame line" })
map("n", "<leader>bd", gitsigns.toggle_deleted, { desc = "[B]lame [D]eleted toggle" })

-- Telescope Git
map("n", "<leader>gc", function()
  require("configs.telescope.custom").my_git_commits()
end, { desc = "[G]it [C]ommits" })
map("n", "<leader>gss", function()
  require("configs.telescope.custom").my_git_status()
end, { desc = "[G]it [S]tatus (Custom)" })
map("n", "<leader>gsh", "<cmd> Telescope git_stash <CR>", { desc = "[G]it [S]tas[h]" })
map("n", "<leader>gbb", "<cmd> Telescope git_branches <CR>", { desc = "[G]it [B]ranches" })
map("n", "<leader>gbc", function()
  require("configs.telescope.custom").my_git_bcommits()
end, { desc = "[G]it [B]ranch [C]ommits" })

-- Git CLI Commands
map("n", "<leader>gpu", "<cmd> Git pull<CR>", { desc = "Git pull" })
map("n", "<leader>gpf", ":Git push ", { desc = "Git push with option" })
map("n", "<leader>gmm", "<cmd> Git merge master<CR>", { desc = "Git merge master" })
map("n", "<leader>gmi", ":Git merge ", { desc = "Git merge..." })
map("n", "<leader>ga", ":Git commit -a --amend --no-edit --no-verify", { desc = "Git [a]mend commit" })
map("n", "<leader>gnb", ":Git checkout -b ", { desc = "Git [n]ew [b]ranch" })
map("n", "<leader>gri", ":Git rebase -i HEAD~", { desc = "Git rebase interactive" })
map("n", "<leader>grm", ":Git rebase -i master", { desc = "Git rebase interactive master" })
map("n", "<leader>grr", ":Git rebase -i ", { desc = "Git rebase interactive..." })
map("n", "<leader>gR", ":Git reset --soft HEAD~", { desc = "Git undo last commit" })

-- Lazygit
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open lazygit" })

-- Flog
map("n", "<F3>", "<cmd> Flog -all<CR>", { desc = "Show git tree (Flog)" })
map("n", "<F4>", "<cmd> tab Git show -", { desc = "Git show N last commits" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         PLUGIN: DEBUGGER (DAP)                  │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

local dap = require "dap"
local dapui = require "dapui"
local dappython = require "dap-python"

map("n", "<leader>dgg", dap.continue, { desc = "[D]ebug [G]o (continue)" })
map("n", "<leader>dg<CR>", dapui.toggle, { desc = "[D]ebug UI Toggle" })
map("n", "<leader>dgw", dapui.eval, { desc = "[D]ebug E[v]al Word" })
map("n", "<leader>dgb", dap.toggle_breakpoint, { desc = "[D]ebug Toggle [B]reakpoint" })
map("n", "<leader>dgf", dappython.test_method, { desc = "[D]ebug Test [F]unction" })
map("v", "<leader>dgd", dappython.debug_selection, { desc = "[D]ebug [S]election" })
map("n", "<leader>dgo", dap.step_over, { desc = "[D]ebug Step [O]ver" })
map("n", "<leader>dgt", dap.step_into, { desc = "[D]ebug Step In[t]o" })
map("n", "<leader>dgp", dap.step_back, { desc = "[D]ebug Step [P]revious" })
map("n", "<leader>dgs", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open { widgth = "50%" }
end, { desc = "[D]ebug [S]copes" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         PLUGIN: MACROS (Macrothis)              │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

local macrothis = require "macrothis"
map("n", "<leader>kkd", macrothis.delete, { desc = "Macro: [d]elete" })
map("n", "<leader>kke", macrothis.edit, { desc = "Macro: [e]dit" })
map("n", "<leader>kkl", macrothis.load, { desc = "Macro: [l]oad" })
map("n", "<leader>kkn", macrothis.rename, { desc = "Macro: re[n]ame" })
map("n", "<leader>kkq", macrothis.quickfix, { desc = "Macro: [q]uickfix" })
map("n", "<leader>kkr", macrothis.run, { desc = "Macro: [r]un" })
map("n", "<leader>kks", macrothis.save, { desc = "Macro: [s]ave" })
map("n", "<leader>kkx", macrothis.register, { desc = "Macro: edit register" })
map("n", "<leader>kkpr", macrothis.copy_register_printable, { desc = "Macro: as [p]rintable [r]egister" })
map("n", "<leader>kkpm", macrothis.copy_macro_printable, { desc = "Macro: as [p]rintable [m]acro" })

-- Custom Macro
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true)
vim.fn.setreg("l", 'yiwoprint(f"' .. esc .. "pa: {" .. esc .. 'pa}")' .. esc)

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         PLUGIN: TROUBLE & LISTS                 │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- Trouble
map("n", "<leader>tx", ":Trouble diagnostics toggle<CR>", { desc = "[T]rouble diagnostics" })
map("n", "<leader>tX", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "[T]rouble buffer diagnostics" })
map("n", "<leader>ts", ":Trouble symbols toggle focus=false<CR>", { desc = "[T]rouble [S]ymbols" })
map("n", "<leader>tl", ":Trouble lsp toggle focus=false win.position=right<CR>", { desc = "[T]rouble [L]SP" })
map("n", "<leader>tL", ":Trouble loclist toggle<CR>", { desc = "[T]rouble [L]oclist" })
map("n", "<leader>tQ", ":Trouble qflist toggle<CR>", { desc = "[T]rouble [Q]uickfix" })

-- Quickfix List
map("n", "<leader>ql", "<cmd> Telescope quickfix <CR>", { desc = "[Q]uickfix [L]ist" })
map("n", "]q", ":cnext<CR>", { desc = "Next in qflist" })
map("n", "<leader>qn", ":cnext<CR>", { desc = "Next in qflist" })
map("n", "[q", ":cprevious<CR>", { desc = "Previous in qflist" })
map("n", "<leader>qp", ":cprevious<CR>", { desc = "Previous in qflist" })
map("n", "<leader>qc", ":call setqflist([]) | cclose<CR>", { desc = "[Q]uickfix [C]lear" })

-- Location List
map("n", "<leader>ll", "<cmd> Telescope loclist <CR>", { desc = "[L]ocation [L]ist" })
map("n", "]l", ":lnext<CR>", { desc = "Next in loclist" })
map("n", "<leader>ln", ":lnext<CR>", { desc = "Next in loclist" })
map("n", "[l", ":lprevious<CR>", { desc = "Previous in loclist" })
map("n", "<leader>lp", ":lprevious<CR>", { desc = "Previous in loclist" })
map("n", "<leader>lc", ":call setloclist([]) | lclose<CR>", { desc = "[L]ocation list [C]lear" })

-- Diaglist
local diaglist = require "diaglist"
map("n", "<leader>dw", function()
  diaglist.open_all_diagnostics()
end, { desc = "[D]iagnostics [W]orkspace" })

map("n", "<leader>d0", function()
  diaglist.open_buffer_diagnostics()
end, { desc = "[D]iagnostics [B]uffer" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         PLUGIN: MISC                            │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- NvimTree
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })

-- Todo Comments
map("n", "<leader>ct", ":call append(line('.') - 1, repeat(' ', indent('.')) . '# TODO: ' . input('Comment >'))<CR>", {
  desc = "Add [T]ODO [C]omment",
})
map("n", "<leader>dtt", ":TodoTelescope keywords=TODO<CR>", { desc = "Show TODOs" })
map("n", "<leader>dtf", ":TodoTelescope keywords=TODO,FIX<CR>", { desc = "Show TODOs + FIX" })

-- WhichKey
map("n", "<leader>wK", function()
  vim.cmd "WhichKey"
end, { desc = "Which-key all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd "WhichKey"
  local input = vim.fn.input "WhichKey: "
  vim.cmd("WhichKey " .. input)
end, { desc = "Which-key query lookup" })

-- Copilot
map("n", "<leader>cop", "<cmd>Copilot enable<CR>", { desc = "[Co]pilot Enable" })
map("n", "<leader>cok", "<cmd>Copilot disable<CR>", { desc = "[Co]pilot Disable" })

-- Tagbar
map("n", "<C-t>", "<cmd> TagbarToggle<CR>", { desc = "Toggle tagbar" })

-- Language-specific views
map("n", "<leader>mk", ":Markview toggle<CR>", { desc = "Toggle [M]ar[k]down view" })
map("n", "<leader>csv", ":CsvViewToggle<CR>", { desc = "Toggle CSV view" })

-- REST Console
map("n", "<leader>ra", "<cmd> call VrcQuery()<CR>", { desc = "[R]un [A]PI request" })

-- ===================================================================
-- ╭─────────────────────────────────────────────────────────────────╮
-- │                         CUSTOM COMMANDS & FUNCTIONS             │
-- ╰─────────────────────────────────────────────────────────────────╯
-- ===================================================================

-- Terminal
map("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })

-- Auto-formatting toggle
vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- Buffer replace
map("n", "<leader>br<CR>", function()
  local pattern = vim.fn.input "Search term:"
  if pattern == "" then
    return
  end

  local replace = vim.fn.input("Replace '" .. pattern .. "' by:")

  if replace == "" then
    return
  end

  local command = "%s/" .. pattern .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "[B]uffer [R]eplace" })

map("n", "<leader>br/", function()
  local replace = vim.fn.input("Replace '" .. vim.fn.getreg "/" .. "' by:")

  if replace == "" then
    return
  end

  local command = "%s/" .. vim.fn.getreg "/" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "[B]uffer [R]eplace from search" })

map("n", "<leader>brw", function()
  local replace = vim.fn.input("Replace '" .. vim.fn.expand "<cword>" .. "' by:")

  if replace == "" then
    return
  end

  local command = "%s/" .. vim.fn.expand "<cword>" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "[B]uffer [R]eplace with [W]ord" })

-- Quickfix replace all
map("n", "<leader>qr<CR>", function()
  local pattern = vim.fn.input "Search term:"
  if pattern == "" then
    return
  end

  local replace = vim.fn.input("Replace '" .. pattern .. "' by:")

  if replace == "" then
    return
  end

  local command = "cfdo %s/" .. pattern .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "[Q]uickfix [R]eplace" })

map("n", "<leader>qr/", function()
  local replace = vim.fn.input("Replace '" .. vim.fn.getreg "/" .. "' by:")

  if replace == "" then
    return
  end

  local command = "cfdo %s/" .. vim.fn.getreg "/" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "[Q]uickfix [R]eplace from search" })

map("n", "<leader>qrw", function()
  local replace = vim.fn.input("Replace '" .. vim.fn.expand "<cword>" .. "' by:")

  if replace == "" then
    return
  end

  local command = "cfdo %s/" .. vim.fn.expand "<cword>" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "[Q]uickfix [R]eplace with [W]ord" })

-- Quickfix "search" (These seemed incomplete, I've left them commented)
-- map("n", "<leader>qs<CR>", function()
--   -- ":execute 'vimgrep' '/' . input('Pattern >') . '\\C/' '**/*' <CR>"
-- end, { desc = "Add <> files in qflist" })
--
-- map("n", "<leader>qs/", function()
--   -- ":execute 'vimgrep' '/' . input('Pattern >', getreg('/')) . '\\C/' '**/*' <CR>"
-- end, { desc = "Add search term files in qflist" })
--
-- map("n", "<leader>qsw", function()
--   -- ":execute 'vimgrep' '/' . input('Pattern >', expand('<cword>')) . '\\C/' '**/*' <CR>"
-- end, { desc = "Add current work files in qflist" })
