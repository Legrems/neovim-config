local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>;", "<cmd> Telescope <CR>", { desc = "Open Telescope" })

-- go to  beginning and end
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

-- navigate within insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

map("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

map("n", "<leader>rr", ":source $MYVIMRC<CR>", { desc = "Reload config file" })
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })
-- switch between windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- ["<C-d>"] = { "<cmd> tab Git diff %<CR>", "Git diff this file" },
map("n", "<C-d>", "<cmd> DiffviewOpen -- %<CR>", { desc = "Git diff this file" })
-- map("n", "<C-o>", "<cmd> DiffviewFileHistory %<CR>", { desc = "Git history diff this file" })
map("n", "<C-a-d>", "<cmd> DiffviewClose<CR>", { desc = "Close git diff" })
-- ["<C-p>"] = { "<cmd> tab Git diff<CR>", "Git diff global" },
map("n", "<C-p>", "<cmd> DiffviewOpen<CR>", { desc = "Git diff global" })
map("n", "<a-p>", ":DiffviewOpen HEAD~", { desc = "Show last N commits" })
map("n", "<leader>gd", "<cmd> DiffviewClose<CR>", { desc = "Git diff close" })

-- save
map("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
-- Quit
map("n", "<C-q>", "<cmd> q! <CR>", { desc = "Force quit window" })

-- line numbers
-- map("n", "<leader>n", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
-- map("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })

-- Movement
-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use gmap("n", j|k,n in operator pending mode, {desc =  so it doesn't alter d, y or c behaviou)
-- map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", opts = { expr = true } })
-- map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", opts = { expr = true } })
-- map("n", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", opts = { expr = true } })
-- map("n", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", opts = { expr = true } })

-- Copy/pasting into /tmp
-- map("n", "<leader>y", "<cmd> :w! /tmp/vimtmp<CR>", { desc = "Save into a global tmp file" })
-- map("n", "<leader>p", "<cmd> :r! cat /tmp/vimtmp<CR>", { desc = "Restore from the global tmp file" })

-- (Double) Trouble
map("n", "<leader>tx", ":Trouble diagnostics toggle<CR>", { desc = "[T]rouble diagnostics" })
map("n", "<leader>tX", ":Trouble diagnostics toggle filter.buf=0<CR>", { desc = "[T]rouble buffer diagnostics" })
map("n", "<leader>ts", ":Trouble symbols toggle focus=false<CR>", { desc = "[T]rouble [S]ymbols" })
map(
  "n",
  "<leader>tl",
  ":Trouble lsp toggle focus=false win.position=right<CR>",
  { desc = "[T]rouble [L]sp def / ref / ..." }
)
map("n", "<leader>tL", ":Trouble loclist toggle<CR>", { desc = "[T]rouble [L]oclist" })
map("n", "<leader>tQ", ":Trouble qflist toggle<CR>", { desc = "[T]rouble [Q]uickfix" })

-- DAP
local dap = require "dap"
local dapui = require "dapui"
local dappython = require "dap-python"

map("n", "<leader>dgg", dap.continue, { desc = "Continue debu[g]ging" })
map("n", "<leader>dg<CR>", dapui.toggle, { desc = "Toggle DAP ui" })
map("n", "<leader>dgw", dapui.eval, { desc = "Open floating windows about current [w]ord" })
map("n", "<leader>dgb", dap.toggle_breakpoint, { desc = "Toggle [b]reakpoint" })
map("n", "<leader>dgf", dappython.test_method, { desc = "Debug [f]unction" })
map("v", "<leader>dgd", dappython.debug_selection, { desc = "DAP debug selection" })
map("n", "<leader>dgo", dap.step_over, { desc = "DAP step [o]ver method" })
map("n", "<leader>dgt", dap.step_into, { desc = "DAP step in[t]o method" })
map("n", "<leader>dgp", dap.step_back, { desc = "DAP step back ([p]revious)" })
map("n", "<leader>dgs", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open { widgth = "50%" }
end, { desc = "DAP Show debugged [s]copes" })

-- LSP
map("n", "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP formatting" })

map("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })

-- Indentation
map("v", "<", "<gv", { desc = "Indent line" })
map("v", ">", ">gv", { desc = "Indent line" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#alternative_mapping_for_paste
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text" })

map("n", "<Return>", "o<ESC>", { desc = "Insert new line below" })
map("n", "<BS>", "O<ESC>", { desc = "Insert new line above" })

-- Vim fugitive
map(
  "n",
  "<C-c>",
  "<cmd> vertical topleft Git <bar> vertical resize 50<CR>",
  { desc = "Show Git status on a left pane" }
)

-- Fn shortcuts
-- Tabs management
map("n", "<F1>", "<cmd> tabprevious<CR>", { desc = "Previous tab" })
map("n", "<F2>", "<cmd> tabnext<CR>", { desc = "Next tab" })
map("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tabs" })
map("n", "<F3>", "<cmd> Flog -all<CR>", { desc = "Show git tree" })
map("n", "<F4>", "<cmd> tab Git show -", { desc = "Git show N last commits" })
map("n", "<C-t>", "<cmd> TagbarToggle<CR>", { desc = "Show tagbar" })
map("n", "<leader>ra", "<cmd> call VrcQuery()<CR>", { desc = "Call REST endpoint" })
map("n", "<leader>dl", "0d$", { desc = "Delete line from start" })

-- Git stuffs
map("n", "<leader>gpu", "<cmd> Git pull<CR>", { desc = "Git pull" })
map("n", "<leader>gpf", ":Git push ", { desc = "Git push with option" })
map("n", "<leader>gmm", "<cmd> Git merge master<CR>", { desc = "Git merge master" })
map("n", "<leader>gmi", ":Git merge ", { desc = "Git merge ..." })
map(
  "n",
  "<leader>ga",
  ":Git commit -a --amend --no-edit --no-verify",
  { desc = "Git commit -a --amend --no-edit --no-verify" }
)
map("n", "<leader>gnb", ":Git checkout -b ", { desc = "Checkout to a new branch" })
map("n", "<leader>gri", ":Git rebase -i HEAD~", { desc = "Git rebase interactive from HEAD" })
map("n", "<leader>grm", ":Git rebase -i master", { desc = "Git rebase interactive from master" })
map("n", "<leader>grr", ":Git rebase -i ", { desc = "Git rebase interactive from <select>" })
map("n", "<leader>gR", ":Git reset --soft HEAD~", { desc = "Git 'undo' last commit" })

-- Markdown
-- ["<leader>mkd"] = { "<cmd>lua vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})<CR>", "Open markdown preview" },
-- ["<leader>mkc"] = { "<cmd>lua vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})<CR>", "Open markdown preview" },
map("n", "<leader>mk", ":Markview toggle<CR>", { desc = "Toggle markdown view" })

map("n", "<leader>csv", ":CsvViewToggle<CR>", { desc = "Toggle CSV view" })

-- Movement n + v
map("n", "n", "nzz", { desc = "Next + auto center" })
map("n", "N", "Nzz", { desc = "Previous + auto center" })
map("n", "(", "(zz", { desc = "Previous + auto center" })
map("n", ")", ")zz", { desc = "Previous + auto center" })
map("n", "{", "{zz", { desc = "Previous + auto center" })
map("n", "}", "}zz", { desc = "Previous + auto center" })
map("n", "[[", "[[zz", { desc = "Previous + auto center" })
map("n", "]]", "]]zz", { desc = "Previous + auto center" })

map("n", "<leader>ww", require("nvim-window").pick, { desc = "Pick window to goto" })
map("n", "<leader>wm", ":WinShift<CR>", { desc = "Enter move window mode" })
map("n", "<leader>ws", ":WinShift swap<CR>", { desc = "Swap window, with selection" })
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open lazygit" })

-- Go to - uppercase
map("n", "gf", ":call search('[A-Z]', 'W')<CR>", { desc = "Go to next uppercase" })
map("n", "fg", ":call search('[A-Z]', 'bW')<CR>", { desc = "Go to last uppercase" })

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

-- Gitlab
-- local gitlab = require "gitlab"
-- map("n", "glb", gitlab.choose_merge_request, { desc = "Gitlab: Choose merge request" })
-- map("n", "glr", gitlab.review, { desc = "Gitlab: review" })
-- map("n", "gls", gitlab.summary, { desc = "Gitlab: summary" })
-- map("n", "glo", gitlab.open_in_browser, { desc = "Gitlab: open in browser" })mappings
-- map("n", "glu", gitlab.copy_mr_url, { desc = "Gitlab: open in browser" })
-- map("n", "glO", gitlab.create_mr, { desc = "Gitlab: create MR" })
-- map("n", "glaa", gitlab.add_assignee, { desc = "Gitlab: add_assignee" })

-- map("n", "glb", gitlab.choose_merge_request)
-- map("n", "glr", gitlab.review)
-- map("n", "gls", gitlab.summary)
-- map("n", "glA", gitlab.approve)
-- map("n", "glR", gitlab.revoke)
-- map("n", "glc", gitlab.create_comment)
-- map("v", "glc", gitlab.create_multiline_comment)
-- map("v", "glC", gitlab.create_comment_suggestion)
-- map("n", "glO", gitlab.create_mr)
-- map("n", "glm", gitlab.move_to_discussion_tree_from_diagnostic)
-- map("n", "gln", gitlab.create_note)
-- map("n", "gld", gitlab.toggle_discussions)
-- map("n", "glaa", gitlab.add_assignee)
-- map("n", "glad", gitlab.delete_assignee)
-- map("n", "glla", gitlab.add_label)
-- map("n", "glld", gitlab.delete_label)
-- map("n", "glra", gitlab.add_reviewer)
-- map("n", "glrd", gitlab.delete_reviewer)
-- map("n", "glp", gitlab.pipeline)
-- map("n", "glM", gitlab.merge)
-- map("n", "glu", gitlab.copy_mr_url)
-- map("n", "glP", gitlab.publish_all_drafts)
map(
  "n",
  "<leader>ct",
  ":call append(line('.') - 1, repeat(' ', indent('.')) . '# TODO: ' . input('Comment >'))<CR>",
  { desc = "Add TODO comment + add to qflist" }
)

map("n", "<leader>dtt", ":TodoTelescope keywords=TODO<CR>", { desc = "Show TODOs" })
map("n", "<leader>dtf", ":TodoTelescope keywords=TODO,FIX<CR>", { desc = "Show TODOs + FIX" })

-- Tabufline
-- cycle through buffers
-- local tabufline = require "nvchad.tabufline"
-- map("n", "<tab>", function()
--   tabufline.next()
-- end, { desc = "Goto next buffer" })
--
-- map("n", "<S-tab>", function()
--   tabufline.prev()
-- end, { desc = "Goto prev buffer" })

-- close buffer + hide terminal buffer
-- map("n", "<leader>x", function()
--   tabufline.close_buffer()
-- end, { desc = "Close buffer" })

-- Comment
-- https://github.com/numToStr/Comment.nvim?tab=readme-ov-file#basic-mappings
-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP definition" })
map("n", "K", function()
  vim.lsp.buf.hover()
end, { desc = "LSP hover with Noice UI" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
map("n", "<leader>ls", function()
  vim.lsp.buf.signature_help()
end, { desc = "LSP signature help" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "LSP definition type" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })
map("n", "<leader>lf", function()
  vim.diagnostic.open_float { border = "rounded" }
end, { desc = "Floating diagnostic" })

map("n", "[d", function()
  vim.diagnostic.goto_prev { float = { border = "rounded" } }
end, { desc = "Diagnostic previous" })

map("n", "]d", function()
  vim.diagnostic.goto_next { float = { border = "rounded" } }
end, { desc = "Diagnostic previous" })

map("n", "gK", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config { virtual_lines = new_config }
end, { desc = "Toggle diagnostic virtual_lines" })
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic set location list" })

-- LSP Workspace
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })

-- Nvimtree toggle + focus
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })

-- Telescope
local telescope = require "telescope.builtin"
map("n", "<A-f>", telescope.resume, { desc = "Resume" })
map("n", "<A-k>", telescope.keymaps, { desc = "Show (and search) all [k]eymaps" })
map("n", "<C-g>", telescope.find_files, { desc = "Find files" })
map("n", "<C-x>", function()
  telescope.find_files { follow = true, no_ignore = true, hidden = true }
end, { desc = "Find all" })
map("n", "<C-f>", telescope.live_grep, { desc = "Live grep" })
map("n", "<C-b>", telescope.buffers, { desc = "Find buffers" })

map("n", "<leader>ff", function()
  telescope.live_grep { default_text = "<<<<<<< HEAD" }
end, { desc = "Search for git conflicts" })

-- Live grep
map("n", "<leader>fg<CR>", function()
  telescope.live_grep {}
end, { desc = "Live grep" })

map("n", "<leader>fg/", function()
  telescope.live_grep { default_text = vim.fn.getreg "/" }
end, { desc = "Live grep with search term" })

map("n", "<leader>fgw", function()
  telescope.live_grep { default_text = vim.fn.expand "<cword>" }
end, { desc = "Live grep with current word" })

-- Find files
map("n", "<leader>gf<CR>", function()
  telescope.find_files {}
end, { desc = "Find files" })

map("n", "<leader>gf/", function()
  telescope.find_files { default_text = vim.fn.getreg "/" }
end, { desc = "Find files with search term" })

map("n", "<leader>gfw", function()
  telescope.find_files { default_text = vim.fn.expand "<cword>" }
end, { desc = "Find files with current word" })

-- Buffer replace
map("n", "<leader>br<CR>", function()
  -- ":execute '%s/' . input('Search term >') . '/' . input('Replace by >', '') . '/g | update' <CR>",

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
end, { desc = "Replace pattern in current buffer" })

map("n", "<leader>br/", function()
  local replace = vim.fn.input("Replace '" .. vim.fn.getreg "/" .. "' by:")

  if replace == "" then
    return
  end

  local command = "%s/" .. vim.fn.getreg "/" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "Replace search term pattern in current buffer" })

map("n", "<leader>brw", function()
  local replace = vim.fn.input("Replace '" .. vim.fn.expand "<cword>" .. "' by:")

  if replace == "" then
    return
  end

  local command = "%s/" .. vim.fn.expand "<cword>" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "Replace current word pattern in current buffer" })

-- Quickfix list
map("n", "<leader>ql", "<cmd> Telescope quickfix <CR>", { desc = "Show qflist" })
map("n", "<leader>qn", ":cnext<CR>", { desc = "Jump to next in qflist" })
map("n", "]q", ":cnext<CR>", { desc = "Jump to next in qflist" })
map("n", "<leader>qp", ":cprevious<CR>", { desc = "Jump to previous in qflist" })
map("n", "[q", ":cprevious<CR>", { desc = "Jump to previous in qflist" })
map("n", "<leader>qc", ":call setqflist([]) | cclose<CR>", { desc = "Clear qflist" })

-- Quickflix replace all
map("n", "<leader>qr<CR>", function()
  -- ":execute 'cfdo' '%s/' . input('Search term >') . '/' . input('Replace by >') . '/gI | update' <CR>",
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
end, { desc = "Replace pattern in all qflist" })

map("n", "<leader>qr/", function()
  -- ":execute 'cfdo' '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >') . '/gI | update' <CR>",
  local replace = vim.fn.input("Replace '" .. vim.fn.getreg "/" .. "' by:")

  if replace == "" then
    return
  end

  local command = "cfdo %s/" .. vim.fn.getreg "/" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "Replace search term in all qflist" })

map("n", "<leader>qrw", function()
  -- ":execute 'cfdo' '%s/' . input('Search term >', expand('<cword>')) . '/' . input('Replace by >') . '/gI | update' <CR>",
  local replace = vim.fn.input("Replace '" .. vim.fn.expand "<cword>" .. "' by:")

  if replace == "" then
    return
  end

  local command = "cfdo %s/" .. vim.fn.expand "<cword>" .. "/" .. replace .. "/g"
  vim.fn.execute(command)
end, { desc = "Replace current work in all qflist" })

-- Quickfix "search"
map("n", "<leader>qs<CR>", function()
  -- ":execute 'vimgrep' '/' . input('Pattern >') . '\\C/' '**/*' <CR>"
end, { desc = "Add <> files in qflist" })

map("n", "<leader>qs/", function()
  -- ":execute 'vimgrep' '/' . input('Pattern >', getreg('/')) . '\\C/' '**/*' <CR>",
end, { desc = "Add search term files in qflist" })

map("n", "<leader>qsw", function()
  -- ":execute 'vimgrep' '/' . input('Pattern >', expand('<cword>')) . '\\C/' '**/*' <CR>",
end, { desc = "Add current work files in qflist" })

-- Location list (loclist)
map("n", "<leader>ll", "<cmd> Telescope loclist <CR>", { desc = "Show loclist" })
map("n", "<leader>ln", ":lnext<CR>", { desc = "Jump to next in loclist" })
map("n", "]l", ":lnext<CR>", { desc = "Jump to next in loclist" })
map("n", "<leader>lp", ":lprevious<CR>", { desc = "Jump to previous in loclist" })
map("n", "[l", ":lprevious<CR>", { desc = "Jump to previous in loclist" })
map("n", "<leader>lc", ":call setloclist([]) | lclose<CR>", { desc = "Clear loclist" })

-- Telescope
map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Find oldfiles" })
map("n", "<leader>fx<CR>", function()
  telescope.current_buffer_fuzzy_find {}
end, { desc = "Fuzzy find in current buffer" })

map("n", "<leader>fx/", function()
  telescope.current_buffer_fuzzy_find { default_text = vim.fn.getreg "/" }
end, { desc = "Fuzzy find in current buffer with search term" })

map("n", "<leader>fxw", function()
  telescope.current_buffer_fuzzy_find { default_text = vim.fn.expand "<cword>" }
end, { desc = "Fuzzy find in current buffer with current work" })

map("n", "<leader>wl", "<cmd> Telescope workspaces <CR>", { desc = "Find workspaces" })
map("n", "<leader>gm", function()
  require("configs.telescope.custom").cpickers()
end, { desc = "Commonly used commands" })

-- Git
map("n", "<leader>gc", function()
  require("configs.telescope.custom").my_git_commits()
end, { desc = "Custom Git commits" })
map("n", "<leader>gss", function()
  require("configs.telescope.custom").my_git_status()
end, { desc = "Custom Git status" })
map("n", "<leader>gsh", "<cmd> Telescope git_stash <CR>", { desc = "Git stash" })
map("n", "<leader>gbb", "<cmd> Telescope git_branches <CR>", { desc = "Git branches" })
map("n", "<leader>gbc", function()
  require("configs.telescope.custom").my_git_bcommits()
end, { desc = "Custom Git branchs commits" })

-- Telescope hidden term
map("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "Telescope pick hidden term" })
-- Marks
map("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "Telescope marks" })

-- Telescope history
map("n", "<leader>ch", "<cmd> Telescope command_history <CR>", { desc = "telescope commands history" })
map("n", "<leader>/", "<cmd> Telescope search_history <CR>", { desc = "telescope search history" })

-- Diaglist: LSP diagnostics in quick/loc list
local diaglist = require "diaglist"
map("n", "<leader>dw", function()
  diaglist.open_all_diagnostics()
end, { desc = "Open all open buffers diagnostics in qflist" })

map("n", "<leader>d0", function()
  diaglist.open_buffer_diagnostics()
end, { desc = "Open current buffer diagnostics in qflist" })

-- WhichKey
map("n", "<leader>wK", function()
  vim.cmd "WhichKey"
end, { desc = "Which-key all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd "WhichKey"
  local input = vim.fn.input "WhichKey: "
  vim.cmd("WhichKey " .. input)
end, { desc = "Which-key query lookup" })

-- Git hunk
local gitsigns = require "gitsigns"
map("n", "]c", function()
  if vim.wo.diff then
    -- Use default vim ]c when in diff mode
    vim.cmd.normal { "]c", bang = true }
  else
    gitsigns.nav_hunk "next"
  end
end, { desc = "Git: Jump to next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    -- Use default vim ]c when in diff mode
    vim.cmd.normal { "[c", bang = true }
  else
    gitsigns.nav_hunk "prev"
  end
end, { desc = "Git: Jump to prev hunk" })

map("n", "<leader>rh", gitsigns.reset_hunk, { desc = "Git Reset hunk" })
map("n", "<leader>ph", gitsigns.preview_hunk, { desc = "Git Preview hunk" })
map("n", "<leader>bb", gitsigns.blame_line, { desc = "Git Blame line" })
map("n", "<leader>bd", gitsigns.toggle_deleted, { desc = "Git Toggle deleted" })

-- Macrothis
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

-- Override all delete/yank/paste to use the registers M by default
map({ "n", "v" }, "y", '"my', { desc = "Yank", remap = false })
map({ "n", "v" }, "p", '"mp', { desc = "Paste", remap = false })
map({ "n", "v" }, "d", '"md', { desc = "Delete", remap = false })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank into system register", remap = false })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste into system register", remap = false })

-- Custom Macro
local esc = vim.api.nvim_replace_termcodes("<ESC>", true, true, true)

vim.fn.setreg("l", 'yiwoprint(f"' .. esc .. "pa: {" .. esc .. 'pa}")' .. esc)

-- Copilot
map("n", "<leader>cop", "<cmd>Copilot enable<CR>", { desc = "Copilot enable" })
map("n", "<leader>cok", "<cmd>Copilot disable<CR>", { desc = "Copilot disable" })
