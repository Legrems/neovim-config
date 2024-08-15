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
  { "emaniacs/vim-rest-console", lazy = false },
  { "mfussenegger/nvim-dap", lazy = false },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    lazy = false,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    lazy = false,
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
    lazy = false,
    config = function(_, _)
      require("persistent-breakpoints").setup {
        load_breakpoints_event = { "BufReadPost" },
      }
    end,
  },
  { "nvim-telescope/telescope-live-grep-args.nvim", lazy = false },
  { "nvim-telescope/telescope-dap.nvim", lazy = false },
  -- {
  --   "harrisoncramer/gitlab.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "sindrets/diffview.nvim",
  --     "stevearc/dressing.nvim", -- Recommended but not required. Better UI for pickers.
  --     "nvim-tree/nvim-web-devicons", -- Recommended but not required. Icons in discussion tree.
  --   },
  --   enabled = true,
  --   lazy = false,
  --   build = function()
  --     require("gitlab.server").build(true)
  --   end, -- Builds the Go binary
  --   opts = function()
  --     return require "configs.gitlab"
  --   end,
  --   config = function(_, opts)
  --     require("gitlab").setup(opts)
  --   end,
  -- },
  {
    "sindrets/diffview.nvim",
    lazy = false,
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
    lazy = false,
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
            if conform.get_formatter_info("ruff_format", bufnr).available then
              return { "isort", "black" }
              -- return { "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
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
      dofile(vim.g.base46_cache .. "devicons")
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
      dofile(vim.g.base46_cache .. "syntax")
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
    -- config = function(_, opts)
    --   dofile(vim.g.base46_cache .. "git")
    --   require("gitsigns").setup(opts)
    -- end,
  },

  -- lsp stuff
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.mason"
    end,
    -- config = function(_, opts)
    --   dofile(vim.g.base46_cache .. "mason")
    --   require("mason").setup(opts)
    --
    --   -- custom nvchad cmd to install all mason binaries listed
    --   vim.api.nvim_create_user_command("MasonInstallAll", function()
    --     if opts.ensure_installed and #opts.ensure_installed > 0 then
    --       vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    --     end
    --   end, {})
    --
    --   vim.g.mason_binaries_list = opts.ensure_installed
    -- end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- load luasnips + cmp related in insert mode only
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require "configs.luasnip"(opts)
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
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
    keys = {
      {
        "<Leader>kkd",
        function()
          require("macrothis").delete()
        end,
        desc = "[D]elete",
      },
      {
        "<Leader>kke",
        function()
          require("macrothis").edit()
        end,
        desc = "[E]dit",
      },
      {
        "<Leader>kkl",
        function()
          require("macrothis").load()
        end,
        desc = "[L]oad",
      },
      {
        "<Leader>kkn",
        function()
          require("macrothis").rename()
        end,
        desc = "Re[n]ame",
      },
      {
        "<Leader>kkq",
        function()
          require("macrothis").quickfix()
        end,
        desc = "Run macro on all files in [q]uickfix",
      },
      {
        "<Leader>kkr",
        function()
          require("macrothis").run()
        end,
        desc = "[R]un macro",
      },
      {
        "<Leader>kks",
        function()
          require("macrothis").save()
        end,
        desc = "[S]ave",
      },
      {
        "<Leader>kkx",
        function()
          require("macrothis").register()
        end,
        desc = "Edit register",
      },
      {
        "<Leader>kkp",
        function()
          require("macrothis").copy_register_printable()
        end,
        desc = "Co[p]y register as printable",
      },
      {
        "<Leader>kkm",
        function()
          require("macrothis").copy_macro_printable()
        end,
        desc = "Copy [m]acro as printable",
      },
    },
  },
  {
    "onsails/diaglist.nvim",
    lazy = false,
    debug = false,
  },

  {
    "anuvyklack/hydra.nvim",
    lazy = false,
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
    lazy = false,

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
    lazy = false,
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
    lazy = false,
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
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "nvimtree")
      require("nvim-tree").setup(opts)
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
      -- dofile(vim.g.base46_cache .. "telescope")
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
    lazy = false,
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
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
    init = function()
      require("noice").setup {
        routes = {
          {
            view = "notify",
            filter = { event = "msg_showmode" },
          },
        },
        lsp = {
          signature = {
            enabled = false,
          },
        },
      }
      -- require("notify").setup({
      --   background_colour = "#000000"
      -- })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    cmd = "Trouble",
    opts = {},
  },
}
