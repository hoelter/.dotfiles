-- Neovim 0.12 built-in treesitter config (replaces archived nvim-treesitter plugin).
-- Requires tree-sitter CLI: brew install tree-sitter

local no_treesitter_hl = { "tsx", "jsx", "dockerfile" }
local no_treesitter_indent = { "yaml", "ruby" }

-- Auto-install parsers on startup (only installs missing ones)
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("treesitter_install", { clear = true }),
  callback = function()
    local wanted = {
      "bash", "c", "c_sharp", "cpp", "css", "go", "html",
      "javascript", "json", "lua", "markdown", "prisma",
      "python", "ruby", "rust", "tsx", "typescript", "vim",
      "vimdoc", "yaml",
    }
    for _, lang in ipairs(wanted) do
      if not pcall(vim.treesitter.language.add, lang) then
        pcall(vim.treesitter.install, lang)
      end
    end
  end,
})

-- Enable treesitter highlighting per-buffer
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  callback = function(args)
    local disabled = {}
    for _, ft in ipairs(no_treesitter_hl) do disabled[ft] = true end
    if disabled[vim.bo[args.buf].filetype] then return end
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Enable treesitter indentation per-buffer
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_indent", { clear = true }),
  callback = function(args)
    local disabled = {}
    for _, ft in ipairs(no_treesitter_indent) do disabled[ft] = true end
    if disabled[vim.bo[args.buf].filetype] then return end
    if pcall(vim.treesitter.get_parser, args.buf) then
      vim.bo[args.buf].indentexpr = "v:lua.require'vim.treesitter'.indentexpr()"
    end
  end,
})

-- Re-enable regex syntax for filetypes where treesitter highlighting is disabled
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("regex_syntax_fallback", { clear = true }),
  pattern = no_treesitter_hl,
  callback = function(args)
    vim.treesitter.stop(args.buf)
    vim.bo[args.buf].syntax = "ON"
  end,
})

-- Return empty spec so lazy.nvim doesn't complain about this file
return {}
