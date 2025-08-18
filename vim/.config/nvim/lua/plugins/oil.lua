return {
  "stevearc/oil.nvim",
  keys = { { "<leader>D", ":Oil<CR>", desc = "Open Oil file manager" } },
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = true
      }
    })
  end,
}