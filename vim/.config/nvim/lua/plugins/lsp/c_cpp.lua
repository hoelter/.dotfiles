-- C/C++ LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = { "clangd" },
  setup = function()
    vim.lsp.config('clangd', {
      on_attach = base.on_attach_lsp,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
    vim.lsp.enable('clangd')
  end
}
