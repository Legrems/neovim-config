return {
  "nvim-lua/plenary.nvim",
  "rebelot/kanagawa.nvim",
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    lazy = false,
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  { "tpope/vim-fugitive", lazy = false },
  { "rbong/vim-flog", lazy = false },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-obsession", lazy = false },
  { "preservim/tagbar", lazy = false },
  { "ludovicchabant/vim-gutentags", lazy = false },
  {
    "emaniacs/vim-rest-console",
    lazy = false,
    config = function()
      vim.g["gutentags_ctags_tagfile"] = "ctagsfile"
    end,
  },
  -- {
  --   "rest-nvim/rest.nvim",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     opts = function(_, opts)
  --       opts.ensure_installed = opts.ensure_installed or {}
  --       table.insert(opts.ensure_installed, "http")
  --     end,
  --   },
  -- },
  { "mfussenegger/nvim-dap", lazy = false },
  {
    "mfussenegger/nvim-lint",
    lazy = false,
    init = function()
      -- require("link").linters_by_ft = {
      --   python = { "mypy" },
      -- }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    init = function()
      require("dap-python").setup "python"
      -- Setup nvim-dap-ui also
      require("dapui").setup()
    end,
    config = function(_, _)
      local dap = require "dap"
      vim.api.nvim_set_hl(0, "dark-orange", { bg = "#402c16" })
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "dark-orange", numhl = "" })
      dap.defaults.fallback.terminal_win_cmd = "tabnew"
      dap.defaults.fallback.focus_terminal = true
    end,
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    config = function(_, _)
      require("persistent-breakpoints").setup {
        load_breakpoints_event = { "BufReadPost" },
      }
    end,
  },
  { "nvim-telescope/telescope-live-grep-args.nvim" },
  { "nvim-telescope/telescope-dap.nvim" },
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
      "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
    },
    lazy = false,
    enabled = true,
    build = function()
      require("gitlab.server").build(true)
    end, -- Builds the Go binary
    opts = function()
      return require "configs.gitlab"
    end,
    config = function(_, opts)
      require("gitlab").setup(opts)
    end,
  },
  {
    "sindrets/diffview.nvim",
    opts = function()
      return require "configs.diffview"
    end,
  },

  {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = { "AdvancedGitSearch" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- optional: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      "sindrets/diffview.nvim",
    },
  },

  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  {
    "stevearc/quicker.nvim",
    opts = {},
    init = function()
      require("quicker").setup()
    end,
  },

  {
    "chentoast/marks.nvim",
    init = function()
      require("marks").setup {
        default_mappings = true,
        signs = true,
        mappings = {},
      }
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {},
    init = function()
      local conform = require "conform"
      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          -- You can use a function here to determine the formatters dynamically
          python = function(bufnr)
            if conform.get_formatter_info("black", bufnr).available then
              return { "isort", "black" }
            else
              return { "ruff_format" }
            end
          end,
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
          vue = { "prettierd" },
        },
        options = {
          lang_to_formatters = {
            json = { "jq" },
          },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_format = "fallback",
        },
      }
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    config = function(_, opts)
      require("nvim-web-devicons").setup(opts)
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    -- version = "2.20.7",
    event = "User FilePost",
    opts = function()
      return require "configs.blankline"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup(require "configs.treesitter_textobjects")
    end,
  },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return require "configs.gitsigns"
    end,
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = function()
      return require "configs.mason-lspconfig"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "configs.lsp"
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- Save and load macro / register
  {
    "desdic/macrothis.nvim",
    opts = {},
  },
  {
    "onsails/diaglist.nvim",
    debug = false,
  },

  {
    "anuvyklack/hydra.nvim",
    config = function()
      require "configs.hydra"
    end,
  },

  {
    "gioele/vim-autoswap",
    lazy = false,
  },

  {
    "natecraddock/workspaces.nvim",

    config = function()
      require("workspaces").setup {
        hooks = {
          open = { "Telescope find_files" },
        },
      }
    end,
  },

  {
    "mangelozzi/rgflow.nvim",
    lazy = false,

    config = function()
      require("rgflow").setup {
        -- Set the default rip grep flags and options for when running a search via
        -- RgFlow. Once changed via the UI, the previous search flags are used for
        -- each subsequent search (until Neovim restarts).
        cmd_flags = "--smart-case --fixed-strings --ignore --max-columns 200",

        -- Mappings to trigger RgFlow functions
        default_trigger_mappings = true,
        -- These mappings are only active when the RgFlow UI (panel) is open
        default_ui_mappings = true,
        -- QuickFix window only mapping
        default_quickfix_mappings = true,
      }
    end,
  },

  {
    "yorickpeterse/nvim-window",
    config = function()
      require("nvim-window").setup {
        normal_hl = "Normal",
        hint_hl = "Bold",
        border = "single",
      }
    end,
  },

  {
    "sindrets/winshift.nvim",
    lazy = false,
  },

  {
    "kdheepak/lazygit.nvim",
    config = function()
      require("lazy").setup {
        {
          "kdheepak/lazygit.nvim",
          -- optional for floating window border decoration
          dependencies = {
            "nvim-lua/plenary.nvim",
          },
        },
      }
    end,
  },

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
      return require "configs.telescope"
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },

  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function()
      return require "configs.noice"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- Uncomment the next line to use nvim-notify
      -- "rcarriga/nvim-notify",
    },
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
  },
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      -- Install tries to automatically detect the install method.
      -- if it fails, try calling it with one of these parameters:
      --    "curl", "wget", "bitsadmin", "go"
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup {

        sources = {
          require("dbee.sources").MemorySource:new {
            {
              name = "localhost",
              type = "postgres",
              url = "postgres://postgres:123@localhost:5432/gestion-isp?sslmode=disable",
            },
            -- ...
          },
        },
      }
    end,
  },
  {
    "hat0uma/csvview.nvim",
    config = function()
      require("csvview").setup()
    end,
    init = function()
      require("csvview").setup {
        view = {
          display_mode = "border",
        },
      }
    end,
  },
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    lazy = false,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },
  {
    "yarospace/lua-console.nvim",
    lazy = true,
    keys = "`",
    opts = {},
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   priority = 999,
  -- },
  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  -- },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   lazy = false,
  --   dependencies = {
  --     { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
  --     { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  --   },
  --   build = "make tiktoken", -- Only on MacOS or Linux
  --   opts = {
  --     -- See Configuration section for options
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },
  -- {
  --   "legrems/better-telescope-history",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "kkharji/sqlite.lua",
  --   },
  --   config = function()
  --     require("telescope-history").setup {
  --       -- Configuration options (see below)
  --     }
  --
  --     -- Load the Telescope extension
  --     require("telescope").load_extension "history"
  --   end,
  -- },
  { "wakatime/vim-wakatime", lazy = false },
}
