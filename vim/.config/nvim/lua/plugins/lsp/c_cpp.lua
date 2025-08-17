-- C/C++ LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = { "clangd" },
  setup = function()
    local lspconfig = require('lspconfig')
    
    lspconfig.clangd.setup({
      on_attach = base.on_attach_lsp,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
  end
}