local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<A-f>", ":Telescope resume  <CR>", { desc = "Telescope resume" })
map("n", "<A-k>", ":Telescope keymaps <CR>", { desc = "Show (and search) all [k]eymaps" })

map("n", "<C-g>", ":Telescope find_files <CR>", { desc = "Find files" })
map("n", "<C-x>", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all files" })
map("n", "<C-f>", ":Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<C-b>", ":Telescope buffers <CR>", { desc = "Find buffers" })
map("n", "<leader>/<CR>", ":Telescope search_history <CR>", { desc = "Search history" })
map("n", "<leader>//", ":noh<CR>", { desc = "Clear highlights" })

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
map("n", "<C-o>", "<cmd> DiffviewFileHistory %<CR>", { desc = "Git history diff this file" })
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
map("n", "<leader>dgg", ":lua require('dap').continue() <CR>", { desc = "Continue debu[g]ging" })
map("n", "<leader>dg<CR>", ":lua require('dapui').toggle() <CR>", { desc = "Toggle DAP ui" })
map("n", "<leader>dgw", ":lua require('dapui').eval() <CR>", { desc = "Open floating windows about current [w]ord" })
map("n", "<leader>dgb", ":lua require('dap').toggle_breakpoint() <CR>", { desc = "Toggle [b]reakpoint" })
map("n", "<leader>dgf", ":lua require('dap-python').test_method() <CR>", { desc = "Debug [f]unction" })
map("n", "<leader>dgo", ":lua require('dap').step_over() <CR>", { desc = "DAP step [o]ver method" })
map("n", "<leader>dgt", ":lua require('dap').step_into() <CR>", { desc = "DAP step in[t]o method" })
map("n", "<leader>dgp", ":lua require('dap').step_back() <CR>", { desc = "DAP step back ([p]revious)" })
map("n", "<leader>dgs", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open { widgth = "50%" }
end, { desc = "DAP Show debugged [s]copes" })
map("v", "<leader>dgd", ":lua require('dap-python').debug_selection()", { desc = "DAP debug selection" })
map("v", "<leader>dgw", ":lua require('dap-python').eval()", { desc = "DAP eval selection" })

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
map("n", "<F1>", "<cmd> tabprevious<CR>", { desc = "Previous tab" })
map("n", "<F2>", "<cmd> tabnext<CR>", { desc = "Next tab" })
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

-- Markdown
-- ["<leader>mkd"] = { "<cmd>lua vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})<CR>", "Open markdown preview" },
-- ["<leader>mkc"] = { "<cmd>lua vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})<CR>", "Open markdown preview" },

-- Movement n + v
map("n", "n", "nzz", { desc = "Next + auto center" })
map("n", "N", "Nzz", { desc = "Previous + auto center" })
map("n", "(", "(zz", { desc = "Previous + auto center" })
map("n", ")", ")zz", { desc = "Previous + auto center" })
map("n", "{", "{zz", { desc = "Previous + auto center" })
map("n", "}", "}zz", { desc = "Previous + auto center" })
map("n", "[[", "[[zz", { desc = "Previous + auto center" })
map("n", "]]", "]]zz", { desc = "Previous + auto center" })

map("n", "<leader>ww", ":lua require('nvim-window').pick()<CR>", { desc = "Pick window to goto" })
map("n", "<leader>wm", ":WinShift<CR>", { desc = "Enter move window mode" })
map("n", "<leader>ws", ":WinShift swap<CR>", { desc = "Swap window, with selection" })
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open lazygit" })
map("n", "gf", ":call search('[A-Z]', 'W')<CR>", { desc = "Go to next uppercase" })
map("n", "fg", ":call search('[A-Z]', 'bW')<CR>", { desc = "Go to last uppercase" })
map("n", "glb", ":lua require('gitlab').choose_merge_request()<CR>", { desc = "Gitlab: Choose merge request" })
map("n", "glr", ":lua require('gitlab').review()<CR>", { desc = "Gitlab: review" })
map("n", "gls", ":lua require('gitlab').summary()<CR>", { desc = "Gitlab: summary" })
map("n", "glo", ":lua require('gitlab').open_in_browser()<CR>", { desc = "Gitlab: open in browser" })
map("n", "glu", ":lua require('gitlab').copy_mr_url()<CR>", { desc = "Gitlab: open in browser" })
map("n", "glO", ":lua require('gitlab').create_mr()<CR>", { desc = "Gitlab: create MR" })
map("n", "glaa", ":lua require('gitlab').add_assignee()<CR>", { desc = "Gitlab: add_assignee" })

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

-- Tabufline
-- cycle through buffers
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Goto next buffer" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev buffer" })

-- close buffer + hide terminal buffer
-- map("n", "<leader>x", function()
--   require("nvchad.tabufline").close_buffer()
-- end, { desc = "Close buffer" })

-- Comment
map("n", "<leader>ci", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map(
  "v",
  "<leader>ci",
  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Toggle comment" }
)

-- LSP
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
map("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "LSP definition type" })
--map("n", "<leader>ra", require("nvchad.renamer").open, { desc = "LSP rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
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
-- map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic set location list" })

-- LSP Workspace
map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Add workspace folder" })
map("n", "]d", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })

map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

-- Nvimtree toggle + focus
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })

-- Telescope
map("n", "<A-f>", "<cmd> Telescope resume <CR>", { desc = "Resume" })
map("n", "<A-k>", "<cmd> Telescope keymaps <CR>", { desc = "Show (and search) all [k]eymaps" })
map("n", "<C-g>", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<C-x>", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
map("n", "<C-f>", "<cmd> Telescope live_grep <CR>", { desc = "Live grep" })
map("n", "<C-b>", "<cmd> Telescope buffers <CR>", { desc = "Find buffers" })

map("n", "<leader>ff", function()
  require("telescope.builtin").live_grep { default_text = "<<<<<<< HEAD" }
end, { desc = "Search for git conflicts" })

-- Live grep
map("n", "<leader>fg<CR>", function()
  require("telescope.builtin").live_grep {}
end, { desc = "Live grep" })

map("n", "<leader>fg/", function()
  require("telescope.builtin").live_grep { default_text = vim.fn.getreg "/" }
end, { desc = "Live grep with search term" })

map("n", "<leader>fgw", function()
  require("telescope.builtin").live_grep { default_text = vim.fn.expand "<cword>" }
end, { desc = "Live grep with current word" })

-- Find files
map("n", "<leader>gf<CR>", function()
  require("telescope.builtin").find_files {}
end, { desc = "Find files" })

map("n", "<leader>gf/", function()
  require("telescope.builtin").find_files { default_text = vim.fn.getreg "/" }
end, { desc = "Find files with search term" })

map("n", "<leader>gfw", function()
  require("telescope.builtin").find_files { default_text = vim.fn.expand "<cword>" }
end, { desc = "Find files with current word" })

-- Buffer replace
map("n", "<leader>br<CR>", function()
  -- ":execute '%s/' . input('Search term >') . '/' . input('Replace by >', '') . '/g | update' <CR>",
end, { desc = "Replace pattern in current buffer" })

map("n", "<leader>br/", function()
  -- ":execute '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >', '') . '/g | update' <CR>",
end, { desc = "Replace search term pattern in current buffer" })

map("n", "<leader>brw", function()
  -- ":execute '%s/' . input('Search term >', expand('<cword>')) . '/' . input('Replace by >', '') . '/g | update' <CR>",
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
end, { desc = "Replace pattern in all qflist" })
map("n", "<leader>qr/", function()
  -- ":execute 'cfdo' '%s/' . input('Search term >', getreg('/')) . '/' . input('Replace by >') . '/gI | update' <CR>",
end, { desc = "Replace search term in all qflist" })
map("n", "<leader>qrw", function()
  -- ":execute 'cfdo' '%s/' . input('Search term >', expand('<cword>')) . '/' . input('Replace by >') . '/gI | update' <CR>",
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
  require("telescope.builtin").current_buffer_fuzzy_find {}
end, { desc = "Fuzzy find in current buffer" })

map("n", "<leader>fx/", function()
  require("telescope.builtin").current_buffer_fuzzy_find { default_text = vim.fn.getreg "/" }
end, { desc = "Fuzzy find in current buffer with search term" })

map("n", "<leader>fxw", function()
  require("telescope.builtin").current_buffer_fuzzy_find { default_text = vim.fn.expand "<cword>" }
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
map("n", "<leader>dw", function()
  require("diaglist").open_all_diagnostics()
end, { desc = "Open all open buffers diagnostics in qflist" })

map("n", "<leader>d0", function()
  require("diaglist").open_buffer_diagnostics()
end, { desc = "Open current buffer diagnostics in qflist" })

map("n", "<leader>;", "<cmd> Telescope <CR>", { desc = "Open Telescope" })

-- Terminal
map({ "n", "t" }, "<A-i>", function()
  require("nvterm.terminal").toggle "float"
end, { desc = "Toggle floating term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvterm.terminal").toggle "horizontal"
end, { desc = "Toggle horizontal term" })

map({ "n", "t" }, "<A-v>", function()
  require("nvterm.terminal").toggle "vertical"
end, { desc = "Toggle vertical term" })

map("n", "<leader>h", function()
  require("nvterm.terminal").new "horizontal"
end, { desc = "New horizontal term" })

map("n", "<leader>v", function()
  require("nvterm.terminal").new "vertical"
end, { desc = "New vertical term" })

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
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to next hunk" })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { desc = "Jump to prev hunk" })

map("n", "<leader>rh", require("gitsigns").reset_hunk, { desc = "Git Reset hunk" })
map("n", "<leader>ph", require("gitsigns").preview_hunk, { desc = "Git Preview hunk" })
map("n", "<leader>bb", require("gitsigns").blame_line, { desc = "Git Blame line" })
map("n", "<leader>bd", require("gitsigns").toggle_deleted, { desc = "Git Toggle deleted" })

-- Override all delete/yank/paste to use the registers M by default
map({ "n", "v" }, "y", '"my', { desc = "Yank", remap = false })
map({ "n", "v" }, "p", '"mp', { desc = "Paste", remap = false })
map({ "n", "v" }, "d", '"md', { desc = "Delete", remap = false })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank into system register", remap = false })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste into system register", remap = false })
