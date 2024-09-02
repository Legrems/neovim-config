-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- lsp settings (for overriding per client)
local handlers = {
  ["textdocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textdocument/signaturehelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

require("lspconfig").pyright.setup {
  on_init = nvlsp.on_init,
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  handlers = handlers,

  settings = {
    pyright = {
      -- options available here: https://github.com/microsoft/pyright/blob/main/docs/settings.md
      disableorganizeimports = true, -- using ruff
      -- disablelanguageservices = true, -- using ruff
    },
    python = {
      analysis = {
        -- ignore = { "*" }, -- using ruff
        -- typecheckingmode = "off", -- using mypy
        diagnosticseverityoverrides = {
          reportmissingimports = false,
          -- reportattributeaccessissue = false,
          reportUnusedVariable = false,
        },
      },
    },
  },
}

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
