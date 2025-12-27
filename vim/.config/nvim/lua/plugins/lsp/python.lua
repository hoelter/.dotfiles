-- Python LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = { "pyright" },
  setup = function()
    vim.lsp.config('pyright', {
      on_attach = base.on_attach_lsp,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
    vim.lsp.enable('pyright')
  end
}
