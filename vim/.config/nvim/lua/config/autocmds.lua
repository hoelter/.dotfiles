local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Neovim built in quick highlight on yank
augroup("highlight_yank", { clear = true })
autocmd("TextYankPost", {
  group = "highlight_yank",
  callback = function()
    vim.highlight.on_yank({ timeout = 100 })
  end,
})

-- WSL yank support
local clip = "/mnt/c/Windows/System32/clip.exe"
if vim.fn.executable(clip) == 1 then
  augroup("WSLYank", { clear = true })
  autocmd("TextYankPost", {
    group = "WSLYank",
    callback = function()
      if vim.v.event.regname == "c" then
        vim.fn.system("cat |" .. clip, vim.fn.getreg("c"))
      end
    end,
  })
end

-- Auto set location list for diagnostics
augroup("locallist", { clear = true })
autocmd("DiagnosticChanged", {
  group = "locallist",
  callback = function()
    vim.diagnostic.setloclist({ open = false })
  end,
})

-- Auto turn off hlsearch
augroup("vimrc_incsearch_highlight", { clear = true })
autocmd("CmdlineEnter", {
  group = "vimrc_incsearch_highlight",
  pattern = { "/", "\\?" },
  command = "set hlsearch",
})
autocmd("CmdlineLeave", {
  group = "vimrc_incsearch_highlight",
  pattern = { "/", "\\?" },
  command = "set nohlsearch",
})

-- Filetype settings
augroup("filetype_settings", { clear = true })

-- Astro support
autocmd({"BufRead", "BufEnter"}, {
  group = "filetype_settings",
  pattern = "*.astro",
  command = "set filetype=astro",
})

-- Indentation changes for various file types (including astro)
local indent_2_filetypes = {
  "astro", "xml", "vim", "markdown", "html", "text", "json", "javascript", "typescript",
  "typescriptreact", "terraform", "lua", "css", "prisma", "scss", "sql", "c", "cpp"
}

autocmd("FileType", {
  group = "filetype_settings",
  pattern = indent_2_filetypes,
  command = "setlocal expandtab ts=2 sw=2",
})

-- Stop yaml comment causing indent
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "yaml",
  command = "setlocal indentkeys-=0#",
})

autocmd("FileType", {
  group = "filetype_settings",
  pattern = "gitconfig",
  command = "setlocal noexpandtab",
})

-- spell check for git commits
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "gitcommit",
  command = "setlocal spell",
})

-- C# Filetype bindings
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "cs",
  callback = function()
    local keymap = vim.keymap
    keymap.set("n", "[m", "k?\\(public\\<bar>private\\)<cr><cmd>nohlsearch<cr>f(b", { buffer = true })
    keymap.set("n", "]m", "/\\(public\\<bar>private\\)<cr><cmd>nohlsearch<cr>f(b", { buffer = true })
    keymap.set("n", "<leader>lR", "?\\(public\\<bar>private\\)<cr><cmd>nohlsearch<cr>f(b<cmd>Telescope lsp_references<cr>", { buffer = true })
    keymap.set("n", "gI", "?\\(public class\\<bar>public interface\\)<cr><cmd>nohlsearch<cr>$<cmd>lua vim.lsp.buf.definition()<CR><C-o>", { buffer = true })
    keymap.set("n", "<leader>{", "<esc>o{<esc>o}<esc>O", { buffer = true })
  end,
})

autocmd({"BufNewFile", "BufRead"}, {
  group = "filetype_settings",
  pattern = "*.cshtml",
  command = "setlocal filetype=razor",
})

autocmd({"BufNewFile", "BufRead"}, {
  group = "filetype_settings",
  pattern = "*.cake",
  command = "setlocal filetype=cs",
})

-- C and C++ bindings
autocmd("FileType", {
  group = "filetype_settings",
  pattern = {"c", "cpp"},
  callback = function()
    local keymap = vim.keymap
    keymap.set("n", "<leader>{", "<esc>o{<esc>o}<esc>O", { buffer = true })
  end,
})

-- javascript and typescript bindings
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "typescript",
  callback = function()
    local keymap = vim.keymap
    keymap.set("n", "<leader>{", "<esc>A {<esc>o}<esc>O", { buffer = true })
  end,
})

-- Disable auto new line comments
autocmd("FileType", {
  group = "filetype_settings",
  pattern = "*",
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

-- Align .env.example with defaults for .env file
autocmd({"BufRead", "BufEnter"}, {
  group = "filetype_settings",
  pattern = "*.env.example",
  command = "set filetype=sh",
})