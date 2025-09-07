return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cpp",
        "css",
        "go",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "prisma",
        "python",
        "ruby",
        "rust",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml"
      },
      highlight = {
          enable = true,              -- false will disable the whole extension
          additional_vim_regex_highlighting = false,
          disable = { 'tsx', 'jsx', 'markdown', 'dockerfile' }
      },
      indent = {
          enable = true,
          disable = { 'yaml', 'ruby' }
      },
      incremental_selection = { enable = true },
      textobjects = { enable = true }
    })
  end,
}
