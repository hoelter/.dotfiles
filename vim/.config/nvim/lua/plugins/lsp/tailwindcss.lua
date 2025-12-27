-- Tailwindcss lsp configuration
local base = require('plugins.lsp._base')

return {
  servers = { "tailwindcss" },
  setup = function()
    vim.lsp.config('tailwindcss', {
      on_attach = base.on_attach_lsp,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
    vim.lsp.enable('tailwindcss')
  end
}
