-- UI and Display
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1" -- more room for symbols left side of page numbers (default: auto)
vim.opt.scrolloff = 8 -- keep 8 lines visible above/below cursor (default: 0)
vim.opt.wrap = false -- don't wrap lines (default: true)
vim.opt.colorcolumn = "120" -- visual guide at column 120 (default: empty)
vim.opt.showmatch = true -- highlight matching brackets (default: false)
vim.opt.pumblend = 25 -- semi-transparent popup menu (default: 0)

-- Buffer and File Management
vim.opt.hidden = true -- allow switching buffers without saving (default in Neovim)
vim.opt.foldenable = false -- disable folding by default (default: true)
vim.opt.modeline = false -- disable modeline for security (default: true)

-- Indentation and Formatting
vim.opt.tabstop = 4 -- tab width (default: 8)
vim.opt.softtabstop = 4 -- backspace behavior (default: 0)
vim.opt.shiftwidth = 4 -- indent width (default: 8)
vim.opt.expandtab = true -- use spaces instead of tabs (default: false)
vim.opt.smartindent = true -- smart auto-indenting (default: false)

-- Search Behavior
vim.opt.ignorecase = true -- case insensitive search (default: false)
vim.opt.smartcase = true -- case sensitive if uppercase present (default: false)

-- Backup and Undo Configuration
vim.opt.backup = false -- disable backup files (default: false)
vim.opt.writebackup = false -- disable backup before writing (default: true)
vim.opt.swapfile = false -- disable swap files (default: true)
vim.opt.undofile = true -- enable persistent undo (default: false)
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- Performance and Timing
vim.opt.updatetime = 750 -- faster CursorHold events (default: 4000ms)

-- Visual Indicators
vim.opt.list = true -- show whitespace characters (default: false)
vim.opt.listchars = "eol:↲,tab:»\\ ,trail:.,extends:<,precedes:>,conceal:┊,nbsp:␣,space:."

-- Input and Interaction
vim.opt.mouse = "a" -- enable mouse support (default in Neovim)

-- Completion Configuration (required for nvim-cmp)
vim.opt.completeopt = {"menu", "menuone", "noselect"}
