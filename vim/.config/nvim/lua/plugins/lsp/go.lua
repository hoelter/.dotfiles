-- Go LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = { "gopls" },
  setup = function()
    vim.lsp.config('gopls', {
      on_attach = function(client, bufnr)
        base.on_attach_lsp(client, bufnr)

        -- Go-specific: <leader>f formats AND organizes imports
        vim.keymap.set('n', '<leader>f', function()
          -- Organize imports first
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" } },
            apply = true,
          })
          -- Then format
          vim.lsp.buf.format()
        end, { buffer = bufnr, desc = "Format and organize imports" })
      end,
      flags = base.common_flags,
      capabilities = base.get_capabilities()
    })
    vim.lsp.enable('gopls')
  end
}
