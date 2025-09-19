-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- lsp settings (for overriding per client)
-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false }),
-- }

vim.lsp.config("*", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  -- handlers = handlers,
})

local servers = {
  "html",
  "cssls",
  "typescript-tools",
  "pyright",
  "jinja_lsp",
  "gopls",
  "tailwindcss",
  "volar",
  "ruff",
}

require("lspconfig")

vim.lsp.enable(servers) 