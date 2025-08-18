-- C# LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = {},  -- Roslyn doesn't use mason
  setup = function()
    -- Roslyn (C#)
    require("roslyn").setup()
    vim.lsp.config("roslyn", {
      cmd = {
        "dotnet",
        vim.fn.expand("~/.lsp/csharp-lsp/content/LanguageServer/osx-arm64/Microsoft.CodeAnalysis.LanguageServer.dll"),
        "--logLevel=information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        "--stdio"
      },
      on_attach = base.on_attach_lsp,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
  end
}