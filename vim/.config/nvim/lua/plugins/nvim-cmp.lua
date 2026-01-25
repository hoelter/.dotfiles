return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
  },
  config = function()
    local lspkind = require("lspkind")
    lspkind.init()
    
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ -- ctrl-y also confirms
          select = true,
          behavior = cmp.ConfirmBehavior.Insert
        }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      }, {
        { name = 'path' },
        { name = 'buffer', keyword_length = 5 },
      }),
      formatting = {
        format = lspkind.cmp_format({
          with_text = true, -- do not show text alongside icons
          menu = {
            buffer = "[buf]",
            nvim_lsp = "[LSP]",
            path = "[path]",
            -- luasnip = "[snip]",
          }
        })
      },
    })
  end,
}
