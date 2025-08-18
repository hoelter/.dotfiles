-- Main LSP loader with auto-discovery

-- Scan for available LSP modules and collect their required servers
local function get_required_servers()
  local servers = {}
  local lsp_dir = vim.fn.stdpath('config') .. '/lua/plugins/lsp'
  
  -- Get all .lua files in the lsp directory (excluding _base.lua and init.lua)
  local handle = vim.loop.fs_scandir(lsp_dir)
  if handle then
    while true do
      local name, type = vim.loop.fs_scandir_next(handle)
      if not name then break end
      
      if type == 'file' and name:match('%.lua$') and 
         name ~= '_base.lua' and name ~= 'init.lua' then
        local module_name = 'plugins.lsp.' .. name:gsub('%.lua$', '')
        
        -- Try to load the module and get its servers
        local ok, module = pcall(require, module_name)
        if ok and module.servers then
          for _, server in ipairs(module.servers) do
            table.insert(servers, server)
          end
        end
      end
    end
  end
  
  return servers
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      build = ":MasonUpdate",
      opts = {},
    },
    {
      "williamboman/mason-lspconfig.nvim",
      opts = function()
        return {
          ensure_installed = get_required_servers(),
          automatic_enable = false,
        }
      end,
    },
    "yioneko/nvim-vtsls",
    "seblyng/roslyn.nvim",
  },
  config = function()
    -- Set up global diagnostic keymaps
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    -- Auto-discover and load LSP configurations
    local lsp_dir = vim.fn.stdpath('config') .. '/lua/plugins/lsp'
    local handle = vim.loop.fs_scandir(lsp_dir)
    
    if handle then
      while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        
        if type == 'file' and name:match('%.lua$') and 
           name ~= '_base.lua' and name ~= 'mason.lua' and name ~= 'init.lua' then
          local module_name = 'plugins.lsp.' .. name:gsub('%.lua$', '')
          
          -- Try to load and setup the LSP module
          local ok, module = pcall(require, module_name)
          if ok and module.setup then
            module.setup()
          else
            vim.notify('Failed to load LSP module: ' .. module_name, vim.log.levels.WARN)
          end
        end
      end
    end
  end,
}