return {
  "hoelter/nord.nvim",
  -- dir = vim.fn.expand("~/my-repos/nord.nvim"),
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("nord")
  end,
}
