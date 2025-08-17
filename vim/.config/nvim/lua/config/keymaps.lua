local keymap = vim.keymap

-- Exit to normal mode
keymap.set("i", "fd", "<Esc>")

-- reload vim config in open vim file
keymap.set("n", "<leader><CR>", ":luafile ~/.config/nvim/init.lua<CR>")

-- next and previous in quickfix list and local list
keymap.set("n", "<C-j>", ":cnext<CR>zz")
keymap.set("n", "<C-k>", ":cprev<CR>zz")
keymap.set("n", "]l", ":lnext<CR>zz")
keymap.set("n", "[l", ":lprev<CR>zz")

-- Toggle quickfix and local list
keymap.set("n", "<C-q>", function()
  local qf_winid = vim.fn.getqflist({winid = 0}).winid
  if qf_winid ~= 0 then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end)

keymap.set("n", "<leader>q", function()
  local ll_winid = vim.fn.getloclist(0, {winid = 0}).winid
  if ll_winid ~= 0 then
    vim.cmd("lclose")
  else
    vim.cmd("lopen")
  end
end)

-- Replace selected section maintaining the original yank in the register
keymap.set("x", "<leader>p", '"_dP')

-- Paste from clipboard, avoids autoindent issues
keymap.set("n", "<leader>P", '"+p')

-- Copy to clipboard
keymap.set({"v", "n"}, "<leader>y", '"+y')
keymap.set("n", "<leader>Y", 'gg"+yG')

-- WSL yank support
local clip = "/mnt/c/Windows/System32/clip.exe"
if vim.fn.executable(clip) == 1 then
  keymap.set({"v", "n"}, "<leader>y", '"cy')
  keymap.set("n", "<leader>Y", 'gg"cyG')
end

-- move visually selected line of code up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- mark executable
keymap.set("n", "<leader>x", ":!chmod +x %<CR>")

-- center screen while searching
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Git mappings
keymap.set("n", "<leader>gs", ":0Git<CR>")
keymap.set("n", "<leader>gh", ":0Gclog<CR>")
keymap.set("n", "<leader>gb", ":Git blame<CR>")
keymap.set("n", "<leader>gp", ":! git add -A && git commit -m 'Quick commit' && git push<CR>")
keymap.set("n", "<leader>gc", ":Git ca <bar> :only<CR>")
keymap.set("n", "<leader>gd", ":Git diff <bar> :only<CR>")

-- toggle local spell check
keymap.set("n", "<F7>", ":setlocal spell! spell?<CR>")

-- Remove search highlight
keymap.set("n", "<leader>/", ":nohlsearch<CR>")

-- Add empty lines, can prefix with number
keymap.set("n", "[<space>", ":<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[")
keymap.set("n", "]<space>", ":<c-u>put =repeat(nr2char(10), v:count1)<cr>")


-- Open word under cursor (primarily for urls)
keymap.set("n", "<leader>o", '"oyiW :exec("!open " . shellescape(getreg("o"), 1) . "")<CR><CR>')

-- Save and close current buffer
keymap.set("n", "<leader>w", ":w<bar>:bd<CR>")

-- re-highlight on yank
keymap.set("v", "Y", "ygv")

-- Treesitter inspect highlight groups under cursor
keymap.set("n", "<leader>i", ":Inspect<CR>")
keymap.set("n", "<leader>I", function()
  if not vim.fn.exists("*synstack") then
    return
  end
  print(vim.inspect(vim.fn.map(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')), 'synIDattr(v:val, "name")')))
end)

-- Copy buffer file path to clipboard
keymap.set("n", "<leader>cP", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
end)