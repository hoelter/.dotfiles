return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local base = require('plugins.lsp._base')
    local linter = base.get_linter()
    local js_formatter = linter == "biome" and { "biome" } or { "prettier" }

    require("conform").setup({
      formatters = {
        erb_format = {
          args = { "--stdin", "--print-width", "120" }
        }
      },
      formatters_by_ft = {
        html = { "prettier" },
        javascript = js_formatter,
        javascriptreact = js_formatter,
        typescript = js_formatter,
        typescriptreact = js_formatter,
        css = { "prettier" },
        eruby = { "erb_format" },
        ["*"] = { "trim_whitespace" },
      },
      default_format_opts = {
        lsp_format = "first",
      },
    })
    
    vim.keymap.set("n", "<leader>f", function()
      require("conform").format()
    end)
  end,
}