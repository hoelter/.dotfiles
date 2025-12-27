-- Ruby LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = { "ruby_lsp" },
  setup = function()
    vim.lsp.config('ruby_lsp', {
      on_attach = base.on_attach_lsp,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
    vim.lsp.enable('ruby_lsp')
  end
}
