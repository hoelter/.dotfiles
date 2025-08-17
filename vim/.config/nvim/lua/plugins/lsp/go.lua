-- Go LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = { "gopls" },
  setup = function()
    local lspconfig = require('lspconfig')
    
    lspconfig.gopls.setup({
      on_attach = base.on_attach_lsp,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
  end
}