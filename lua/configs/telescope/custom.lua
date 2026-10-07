-- Colored diff previewers for git pickers (same hl groups as diffview)

local previewers = require "telescope.previewers"
local builtin = require "telescope.builtin"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local conf = require("telescope.config").values
local entry_display = require "telescope.pickers.entry_display"
local make_entry = require "telescope.make_entry"

local E = {}

local diff_ns = vim.api.nvim_create_namespace "telescope_git_diff"

-- color whole lines with the same hl groups as diffview
local highlight_diff = function(bufnr, lines)
  for i, line in ipairs(lines) do
    local hl
    if line:match "^%+" and not line:match "^%+%+%+" then
      hl = "DiffAdd"
    elseif line:match "^%-" and not line:match "^%-%-%-" then
      hl = "DiffDelete"
    elseif line:match "^@@" then
      hl = "DiffText"
    end
    if hl then
      vim.api.nvim_buf_set_extmark(bufnr, diff_ns, i - 1, 0, { line_hl_group = hl })
    end
  end
end

-- buffer previewer showing the output of get_command(entry) as a colored diff
local diff_previewer = function(get_command)
  return previewers.new_buffer_previewer {
    title = "Diff",
    define_preview = function(self, entry)
      local bufnr = self.state.bufnr
      vim.system(get_command(entry), { text = true }, function(res)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end
          local lines = vim.split(res.stdout or "", "\n", { trimempty = true })
          if #lines == 0 then
            lines = { "No changes" }
          end
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
          vim.bo[bufnr].filetype = "diff"
          highlight_diff(bufnr, lines)
        end)
      end)
    end,
  }
end

local commit_previewer = diff_previewer(function(entry)
  return { "git", "show", "--stat", "--patch", entry.value }
end)

local status_previewer = diff_previewer(function(entry)
  if entry.status == "??" then
    return { "git", "diff", "--no-index", "/dev/null", entry.value }
  end
  return { "git", "diff", "HEAD", "--", entry.value }
end)

local branch_previewer = diff_previewer(function(entry)
  return { "git", "diff", "HEAD..." .. entry.value }
end)

-- <CR> opens the selected commit in diffview
local diffview_commit = function(prompt_bufnr, _)
  actions.select_default:replace(function()
    local selection = action_state.get_selected_entry()
    actions.close(prompt_bufnr)
    vim.cmd("DiffviewOpen " .. selection.value .. "^!")
  end)
  return true
end

-- like `git lg`: <hash> <author initials> <date> <subject>
local commit_log_args = { "log", "--pretty=format:%h%x09%an%x09%ad%x09%s", "--date=format:%Y-%m-%d %H:%M" }

local initials = function(name)
  local out = ""
  for word in name:gmatch "[^%s%-]+" do
    out = out .. vim.fn.toupper(vim.fn.strcharpart(word, 0, 1))
  end
  return out
end

local commit_displayer = entry_display.create {
  separator = " ",
  items = {
    { width = 8 },
    { width = 3 },
    { width = 16 },
    { remaining = true },
  },
}

local commit_entry_maker = function(opts)
  return function(line)
    local sha, author, date, msg = line:match "^([^\t]*)\t([^\t]*)\t([^\t]*)\t(.*)$"
    if not sha then
      return nil
    end
    local short = initials(author)
    return make_entry.set_default_entry_mt({
      value = sha,
      ordinal = table.concat({ sha, short, author, date, msg }, " "),
      msg = msg,
      current_file = opts.current_file,
      display = function()
        return commit_displayer {
          { sha, "TelescopeResultsIdentifier" },
          { short, "TelescopeResultsConstant" },
          { date, "TelescopeResultsComment" },
          msg,
        }
      end,
    }, opts)
  end
end

-- smaller preview so the log line fits on the results side
local commit_layout = { horizontal = { preview_width = 0.45 } }

E.my_git_commits = function(opts)
  opts = opts or {}
  opts.previewer = commit_previewer
  opts.attach_mappings = diffview_commit
  opts.entry_maker = commit_entry_maker(opts)
  opts.git_command = vim.list_extend({ "git" }, vim.list_extend(vim.deepcopy(commit_log_args), { "--", "." }))
  opts.layout_config = opts.layout_config or commit_layout

  builtin.git_commits(opts)
end

E.my_git_bcommits = function(opts)
  opts = opts or {}
  opts.previewer = commit_previewer
  opts.attach_mappings = diffview_commit
  opts.entry_maker = commit_entry_maker(opts)
  opts.git_command = vim.list_extend({ "git" }, vim.list_extend(vim.deepcopy(commit_log_args), { "--follow" }))
  opts.layout_config = opts.layout_config or commit_layout

  builtin.git_bcommits(opts)
end

E.my_git_status = function(opts)
  opts = opts or {}
  opts.previewer = status_previewer

  builtin.git_status(opts)
end

E.my_git_branches = function(opts)
  opts = opts or {}
  opts.previewer = branch_previewer

  builtin.git_branches(opts)
end

E.project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system "git rev-parse --is-inside-work-tree"
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

local custom_commands = require "configs.telescope.commands"

E.cpickers = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Commands",

      finder = finders.new_table {
        results = custom_commands,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry[1],
            ordinal = entry[2],
          }
        end,
      },

      previewer = previewers.new_buffer_previewer {
        title = "Custom commands preview",
        define_preview = function(self, entry, _)
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {
            entry["ordinal"],
          })
        end,
      },

      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd(selection.ordinal)
        end)
        return true
      end,

      sorter = conf.generic_sorter(opts),
    })
    :find()
end

return E
