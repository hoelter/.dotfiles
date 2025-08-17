return {
  "hoelter/nord.nvim",
  -- dir = vim.fn.expand("~/my-repos/nord.nvim"),
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.nord_uniform_diff_background = 1
    vim.cmd.colorscheme("nord")
  end,
}
