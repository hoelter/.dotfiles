-- TypeScript/JavaScript LSP configuration
local base = require('plugins.lsp._base')

return {
  servers = { "eslint", "vtsls" },
  setup = function()
    local lspconfig = require('lspconfig')
    local capabilities = base.get_capabilities()

    -- eslint (JavaScript/TypeScript linting)
    lspconfig.eslint.setup({
      on_attach = function(client, bufnr)
        vim.keymap.set('n', 'gp', '<cmd>EslintFixAll<CR>', { buffer = bufnr })

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
      flags = base.common_flags,
      capabilities = capabilities
    })

    -- vtsls (TypeScript)
    require("lspconfig.configs").vtsls = require("vtsls").lspconfig
    lspconfig.vtsls.setup({
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        base.on_attach_lsp(client, bufnr)

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "go", ":VtsExec organize_imports<CR>", bufopts)
        vim.keymap.set("n", "<leader>rN", ":VtsExec rename_file<CR>", bufopts)
        vim.keymap.set("n", "gp", ":VtsExec add_missing_imports<CR>", bufopts)
      end,
      flags = base.common_flags,
      capabilities = capabilities,
      settings = {
        typescript = {
          preferences = {
            importModuleSpecifier = "non-relative"
          }
        }
      }
    })
  end
}