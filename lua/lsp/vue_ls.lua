return {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    vue = {
      hybridMode = false,
    },
    -- typescript = {
    --   -- replace with your global TypeScript library path
    --   -- tsdk = "/path/to/node_modules/typescript/lib",
    -- },
  },
  on_new_config = function(new_config, new_root_dir)
    local lib_path = vim.fs.find("node_modules/typescript/lib", { path = new_root_dir, upward = true })[1]
    if lib_path then
      -- print("lib path", lib_path)
      new_config.init_options.typescript.tsdk = lib_path
    end
  end,
} 