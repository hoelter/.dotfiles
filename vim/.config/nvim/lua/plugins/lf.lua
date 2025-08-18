return {
  "hoelter/lf.vim",
  dependencies = { "voldikss/vim-floaterm" },
  keys = { { "<leader>d", ":Lf<CR>", desc = "Open LF file manager" } },
  config = function()
    vim.g.lf_width = 0.99
    vim.g.lf_height = 0.99
    vim.g.lf_command_override = 'lf -command "set hidden"'
    vim.g.lf_map_keys = 0
    vim.g.floaterm_opener = 'edit'
  end,
}
