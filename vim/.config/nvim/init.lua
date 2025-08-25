-- Dependencies that should be installed for config to fully work
-- neovim
-- lf
-- ripgrep (https://github.com/BurntSushi/ripgrep)
-- fd (https://github.com/sharkdp/fd)

-- Set leader key first
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration modules after lazy is set up
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugin configuration
require("lazy").setup("plugins", {
  install = { colorscheme = { "nord" } },
  checker = { enabled = false },
})
