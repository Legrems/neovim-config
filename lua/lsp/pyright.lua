return {
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