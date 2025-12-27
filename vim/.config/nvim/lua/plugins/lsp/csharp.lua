-- C# LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = {},  -- Roslyn doesn't use mason
  setup = function()
    -- Plugin setup (no special options needed)
    require("roslyn").setup()

    -- LSP configuration with custom cmd path
    vim.lsp.config("roslyn", {
      cmd = {
        "dotnet",
        vim.fn.expand("~/.lsp/csharp-lsp/content/LanguageServer/osx-arm64/Microsoft.CodeAnalysis.LanguageServer.dll"),
        "--logLevel=information",
        "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        "--stdio"
      },
      on_attach = base.on_attach_lsp,
      capabilities = base.get_capabilities()
    })
  end
}
