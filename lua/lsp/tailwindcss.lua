return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "htmldjango" },
  root_dir = require("lspconfig").util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.config.ts"),
} 