return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    {
      "saadparwaiz1/cmp_luasnip",
      dependencies = {
        "L3MON4D3/LuaSnip",
      },
    },
  },
  config = function()
    local lspkind = require("lspkind")
    lspkind.init()
    
    local cmp = require("cmp")
    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace
        }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'luasnip', keyword_length = 5 },
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
