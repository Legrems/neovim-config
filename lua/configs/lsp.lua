-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

-- lsp settings (for overriding per client)
-- local handlers = {
--   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
--   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
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
  "jinja_lsp",
  "gopls",
  "ts_ls",
  "vue_ls",
  -- "tailwindcss",
}

if vim.fn.executable "pyright" == 1 then
  table.insert(servers, "pyright")
elseif vim.fn.executable "ruff" == 1 then
  table.insert(servers, "ruff")
end

for _, server_name in ipairs(servers) do
  local custom_config_path = "lsp." .. server_name:gsub("%-", "_")
  local ok, custom_config = pcall(require, custom_config_path)

  if ok and custom_config and type(custom_config) == "table" then
    vim.lsp.config[server_name] = custom_config
  end
  vim.lsp.enable(server_name)
end
