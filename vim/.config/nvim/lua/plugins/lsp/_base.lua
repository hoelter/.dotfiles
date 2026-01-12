-- Shared LSP utilities and configuration
local M = {}

-- Search up directory tree for any of the given config files
local function find_config_upward(config_files)
  local dir = vim.fn.getcwd()
  while dir ~= "/" do
    for _, config in ipairs(config_files) do
      if vim.fn.filereadable(dir .. "/" .. config) == 1 then
        return true
      end
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return false
end

-- Detect which linter config exists (biome takes priority)
function M.get_linter()
  local biome_configs = { "biome.json", "biome.jsonc" }
  local eslint_configs = {
    ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
    ".eslintrc.yaml", ".eslintrc.yml", "eslint.config.js",
    "eslint.config.mjs", "eslint.config.cjs"
  }

  if find_config_upward(biome_configs) then return "biome" end
  if find_config_upward(eslint_configs) then return "eslint" end
  return nil
end

-- Common LSP on_attach function
function M.on_attach_lsp(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Enable inlay hints if supported
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Buffer local mappings
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>ci', vim.lsp.buf.incoming_calls, bufopts)
  vim.keymap.set('n', '<space>co', vim.lsp.buf.outgoing_calls, bufopts)
  vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>ih', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, bufopts)
end

-- Get default capabilities from nvim-cmp
function M.get_capabilities()
  return require('cmp_nvim_lsp').default_capabilities()
end

-- Common LSP flags
M.common_flags = {
  debounce_text_changes = 150,
}

return M