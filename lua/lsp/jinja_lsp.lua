local configs = require "lspconfig.configs"

if not configs.jinja_lsp then
  configs.jinja_lsp = {
    default_config = {
      name = "jinja-lsp",
      cmd = { "/home/legrems/.cargo/bin/jinja-lsp" },
      filetypes = { "jinja", "rust", "htmldjango" },
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

return {} 