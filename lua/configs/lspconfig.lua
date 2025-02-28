-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "volar", "typescript-tools" }
-- local servers = { "html", "cssls", "volar", "typescript-tools", "tsserver" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsp settings (for overriding per client)
-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false }),
-- }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    -- handlers = handlers,
  }
end

require("lspconfig").pyright.setup {
  on_init = nvlsp.on_init,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  -- handlers = handlers,

  settings = {
    pyright = {
      -- options available here: https://github.com/microsoft/pyright/blob/main/docs/settings.md
      disableOrganizeImports = true, -- using ruff
      -- disableLanguageServices = true, -- using ruff
    },
    python = {
      analysis = {
        -- ignore = { "*" }, -- using ruff
        -- typeCheckingMode = "off", -- using mypy
        diagnosticSeverityOverrides = {
          -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#diagnostic-settings-defaults
          reportMissingImports = false,
          reportUnusedVariable = false,
          reportIncompatibleVariableOverride = "none",
          reportIncompatibleMethodOverride = "none",
          reportAssignmentType = false,
          reportAttributeAccessIssue = false,
        },
      },
    },
  },
}

-- require("lspconfig").tsserver.setup {
--   filetypes = { "html", "javascript", "htmldjango" },
-- }

-- require("lspconfig").pylsp.setup {
--   settings = {
--     pylsp = {
--       plugins = {
--         pycodestyle = {
--           ignore = { "W391", "E501" },
--           maxLineLength = 100,
--         },
--       },
--     },
--   },
-- }
--

local configs = require "lspconfig.configs"

if not configs.jinja_lsp then
  configs.jinja_lsp = {
    default_config = {
      name = "jinja-lsp",
      cmd = { "/home/legrems/.cargo/bin/jinja-lsp" },
      filetypes = { "jinja", "rust", "htmldjango", "javascript" },
      root_dir = function()
        return "."
      end,
      init_options = {
        templates = "./templates",
        backend = { "./src" },
        lang = "rust",
      },
    },
  }
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.jinja_lsp.setup {
  capabilities = capabilities,
}
lspconfig.gopls.setup {}

lspconfig.tailwindcss.setup {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "htmldjango" },
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
}
