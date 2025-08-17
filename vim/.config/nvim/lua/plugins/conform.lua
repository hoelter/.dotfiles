return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters = {
        erb_format = {
          args = { "--stdin", "--print-width", "120" }
        }
      },
      formatters_by_ft = {
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
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