-- C# LSP configuration
local base = require('plugins.lsp._base')

local roslyn_dir = vim.fn.expand("~/.lsp/roslyn")
local razor_dir = vim.fs.joinpath(roslyn_dir, ".razorExtension")

return {
  servers = {},  -- Roslyn doesn't use mason
  setup = function()
    -- Plugin setup (no special options needed)
    require("roslyn").setup()

    local cmd = {
      "dotnet",
      vim.fs.joinpath(roslyn_dir, "Microsoft.CodeAnalysis.LanguageServer.dll"),
      "--logLevel=Information",
      "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
      "--stdio",
    }

    -- Add razor extension flags if the extension is installed
    if vim.fn.isdirectory(razor_dir) == 1 then
      vim.list_extend(cmd, {
        "--razorSourceGenerator="
          .. vim.fs.joinpath(razor_dir, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
        "--razorDesignTimePath="
          .. vim.fs.joinpath(razor_dir, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
        "--extension",
        vim.fs.joinpath(razor_dir, "Microsoft.VisualStudioCode.RazorExtension.dll"),
      })
    end

    -- LSP configuration with custom cmd path
    vim.lsp.config("roslyn", {
      cmd = cmd,
      filetypes = { "cs", "razor" },
      on_attach = base.on_attach_lsp,
      capabilities = base.get_capabilities(),
      settings = {
        razor = {
          language_server = {
            cohosting_enabled = true,
          },
        },
      },
    })
  end
}
