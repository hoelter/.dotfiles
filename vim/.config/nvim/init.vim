" Dependencies that should be installed for config to fully work
" neovim
" lf
" [ripgrep](https://github.com/BurntSushi/ripgrep)
" [fd](https://github.com/sharkdp/fd)
"
"
"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------

set hidden " buffers don't auto close
set termguicolors
set scrolloff=8
set number
set relativenumber
set signcolumn=yes:1 " more room for symbols left side of page numbers
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nofoldenable
set nowrap
set colorcolumn=120
set updatetime=750 " Unsure of the significance of this, default is 4000
set showmatch " show matching brackets when indicator is over them
set nomodeline " turns off looking for vim commands in files to auto execute

"set cursorline " highlights entire cursor line when turned on
" set numberwidth=20 " make code more centered

" case insensitive search, unless upper case char in pattern
set ignorecase
set smartcase

" Remove backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Enable peristent undo
set undodir=~/.local/share/nvim/undodir
set undofile

" Show white space and other chars
set list
set listchars=eol:↲,tab:»\ ,trail:.,extends:<,precedes:>,conceal:┊,nbsp:␣,space:.

" Neovim semi transparent popup-menu: https://neovim.io/doc/user/options.html#%27pumblend%27
set pumblend=25

if has('mouse')
  set mouse=a
endif

" Neovim built in quick highlight on yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 100})
augroup END


" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.regname ==# 'c' | call system('cat |' . s:clip, @c) | endif
    augroup END
endif


augroup locallist
    autocmd!
    autocmd DiagnosticChanged * lua vim.diagnostic.setloclist({ open = false })
augroup END

" Auto turn off hlsearch
augroup vimrc_incsearch_highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" :call SynStack()
" Identifies highlight group under cursor
" https://stackoverflow.com/a/9464929
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"--------------------------------------------------------------------------
" Key Maps
"--------------------------------------------------------------------------

let mapleader = " "

" Exit to normal mode
imap fd <Esc>

" reload vim config in open vim file, shout out
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" next and previous in quickfix list and local list
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprev<CR>zz

" Toggle quickfix and local list
nnoremap <expr> <C-q> empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'
nnoremap <expr> <leader>q empty(filter(getwininfo(), 'v:val.loclist')) ? ':lopen<CR>' : ':lclose<CR>'

" Replace selected section maintaining the original yank in the register
xnoremap <leader>p "_dP

" Paste from clipboard, avoids autoindent issues
nnoremap <leader>P "+p

" Copy to clipboard
vnoremap <leader>y "+y
" Ready to copy activated area to clipboard
nnoremap <leader>y "+y
" Copy whole file from normal mode to clipboard
nnoremap <leader>Y gg"+yG

if executable(s:clip)
  " Override in wsl to work around bug
  vnoremap <leader>y "cy
  nnoremap <leader>y "cy
  nnoremap <leader>Y gg"cyG
endif

" move visually selected line of code up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" mark executable
nnoremap <leader>x :!chmod +x %<CR>

" to quickly paste from clipboard without strange indents, automate in future
set pastetoggle=<F10>

" center screen while searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Git Status
nnoremap <leader>gs :0Git<CR>
" vim fugitive quickfix commits for current file
nnoremap <leader>gh :0Gclog<CR>
" Git Blame
nnoremap <leader>gb :Git blame<CR>
" Git quick commit and push
nnoremap <leader>gp :! git add -A && git commit -m 'Quick commit' && git push<CR>
" Git add all and commit
nnoremap <leader>gc :Git ca <bar> :only<CR>
" Git diff
nnoremap <leader>gd :Git diff <bar> :only<CR>
" Better potential diffing
" https://github.com/tpope/vim-fugitive/issues/132#issuecomment-649516204

" toggle local spell check
nnoremap <F7> :setlocal spell! spell?<CR>

" Remove search highlight
nnoremap <leader>/ :nohlsearch<CR>

" Add empty lines, can prefix with number
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Show crlf line endings
" :e ++ff=unix
" remove crlf line endings
" :%s/\r//
"
" Open netrw
nnoremap <leader>D :Ex<CR>

" Open word under cursor (primarily for urls)
nnoremap <leader>o "oyiW :exec("!open " . shellescape('<C-R>o', 1) . "")<CR><CR>

" Save and close current buffer
nnoremap <leader>w :w<bar>:bd<CR>

" re-highlight on yank
vnoremap Y ygv

" Inspect highlight groups under cursor
nnoremap <leader>i :Inspect<CR>
nnoremap <leader>I :call SynStack()<CR>

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------
" Automate vim.plug install if it's not yet installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

" Telescope dependencies https://github.com/nvim-telescope/telescope.nvim
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'benfowler/telescope-luasnip.nvim'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" Lf vim
" Plug 'ptzz/lf.vim'
Plug 'hoelter/lf.vim'
Plug 'voldikss/vim-floaterm'

" honor .editorconfig file settings
Plug 'editorconfig/editorconfig-vim'

" Theme
"Plug '~/my-repos/nord.nvim'
Plug 'hoelter/nord.nvim'

" Neovim native lsp
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
" cmp-extra completion info
Plug 'onsails/lspkind.nvim'
" Snippet Plugin
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" Git helper
Plug 'tpope/vim-fugitive'

" Treesitter aware comments
Plug 'folke/ts-comments.nvim',

" Auto Indent html and tsx files
Plug 'windwp/nvim-ts-autotag'

" Omnisharp Specific Decompilation Support
Plug 'hoelter/omnisharp-extended-lsp.nvim'
" Razor page syntax highlighting
Plug 'hoelter/vim-razor'

" Log File syntax highlighting
Plug 'mtdl9/vim-log-highlighting'

" Marks alternative
Plug 'ThePrimeagen/harpoon'

" Indentation guides
"Plug 'lukas-reineke/indent-blankline.nvim'

" Surround Action
Plug 'tpope/vim-surround'

" Line diff
Plug 'AndrewRadev/linediff.vim'

" Highlight color strings
Plug 'norcalli/nvim-colorizer.lua'

" https://github.com/stevearc/oil.nvim
Plug 'stevearc/oil.nvim'

" --------- Start under evaluation
" https://github.com/tpope/vim-abolish
" Plug 'tpope/vim-abolish'
" https://github.com/mbbill/undotree
Plug 'mbbill/undotree'

" https://github.com/williamboman/mason.nvim
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" https://github.com/stevearc/conform.nvim
Plug 'stevearc/conform.nvim'

" Typescript related
" https://github.com/pmizio/typescript-tools.nvim
Plug 'pmizio/typescript-tools.nvim'

" Alternative
"Plug 'pmizio/typescript-tools.nvim'
" https://github.com/yioneko/nvim-vtsls
Plug 'yioneko/nvim-vtsls'

"https://github.com/tpope/vim-rails
" Plug 'tpope/vim-rails'

" --------- End under evaluation

call plug#end()

"--------------------------------------------------------------------------
" Custom Language Settings (post treesitter)
"--------------------------------------------------------------------------

" Filetype settings
augroup filetype_settings
  autocmd!

  " Astro support
  autocmd BufRead,BufEnter *.astro set filetype=astro
  autocmd Filetype astro setlocal expandtab ts=2 sw=2

  " indentation changes
  autocmd Filetype xml setlocal expandtab ts=2 sw=2
  autocmd Filetype vim setlocal expandtab ts=2 sw=2
  autocmd Filetype markdown setlocal expandtab ts=2 sw=2
  autocmd Filetype text setlocal expandtab ts=2 sw=2
  autocmd Filetype json setlocal expandtab ts=2 sw=2
  autocmd Filetype javascript setlocal expandtab ts=2 sw=2
  autocmd Filetype typescript setlocal expandtab ts=2 sw=2
  autocmd Filetype typescriptreact setlocal expandtab ts=2 sw=2
  autocmd Filetype terraform setlocal expandtab ts=2 sw=2
  autocmd Filetype lua setlocal expandtab ts=2 sw=2
  autocmd Filetype css setlocal expandtab ts=2 sw=2
  autocmd Filetype prisma setlocal expandtab ts=2 sw=2
  autocmd Filetype scss setlocal expandtab ts=2 sw=2
  autocmd Filetype sql setlocal expandtab ts=2 sw=2

  " Stop yaml comment causing indent
  autocmd Filetype yaml setlocal indentkeys-=0#
  autocmd Filetype gitconfig setlocal noexpandtab
  "autocmd BufNewFile,BufRead *.yml,*.yaml setlocal indentkeys-=0#

  " spell chek for git commits
  autocmd FileType gitcommit setlocal spell

  " C# Filetype bindings
  autocmd FileType cs noremap <buffer> [m k?\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b
  autocmd FileType cs noremap <buffer> ]m /\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b
  autocmd FileType cs nnoremap <buffer> <leader>lR ?\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b<cmd>Telescope lsp_references<cr>
  autocmd FileType cs nnoremap <buffer> gI ?\(public class\<bar>public interface\)<cr><cmd>nohlsearch<cr>$<cmd>:lua vim.lsp.buf.definition()<CR><C-o>
  autocmd FileType cs nnoremap <leader>ld <cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>
  "autocmd FileType cs nnoremap <buffer> gmI ?\(public class\<bar>public interface\)<cr><cmd>nohlsearch<cr>$<cmd>:lua vim.lsp.buf.definition()<CR><C-o>
  autocmd FileType cs nnoremap <buffer> <leader>{ <esc>o{<esc>o}<esc>O
  autocmd BufNewFile,BufRead *.cshtml setlocal filetype=razor " Force filteype to use plugin defined syntax
  autocmd BufNewFile,BufRead *.cake setlocal filetype=cs

  autocmd FileType cpp nnoremap <buffer> <leader>{ <esc>o{<esc>o}<esc>O
  autocmd FileType typescript nnoremap <buffer> <leader>{ <esc>A {<esc>o}<esc>O

  " Disable auto new line comments
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

  " Align .env.example with defaults for .env file
  autocmd BufRead,BufEnter *.env.example set filetype=sh

augroup END

"--------------------------------------------------------------------------
" Plugin Settings
"--------------------------------------------------------------------------

" Load color scheme after plugins
let g:nord_uniform_diff_background = 1
colorscheme nord

" No longer need this telescope hilight, second line is for search override highligth
" hi! link TelescopeMatching Label " Assigns label color to telesscope match highlighting
" hi! Search guifg=#88C0D0 guibg=#3B4252 ctermfg=6 ctermbg=0 gui=reverse term=reverse

" Lf Settings
" https://github.com/ptzz/lf.vim
let g:lf_width = 0.99
let g:lf_height = 0.99
" Show hidden files by default
let g:lf_command_override = 'lf -command "set hidden"'
" Disable default mapping and remap
let g:lf_map_keys = 0
nnoremap <leader>d :Lf<CR>


" Color highlighting https://github.com/norcalli/nvim-colorizer.lua
lua <<EOF
require'colorizer'.setup {
    'html';
    'css';
    'json';
    'scss';
    'javascript';
    'typescript';
    'typescriptreact';
    'html';
    'fish';
    'lua';
}
EOF

" Oil Nvim setup
lua <<EOF
    require("oil").setup({
        view_options = {
            show_hidden = true
        }
    })
EOF
nnoremap <leader>D :Oil<CR>

" Harpoon Setup
lua <<EOF
    require("harpoon").setup({
        menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
        },
        global_settings = {
            enter_on_sendcmd = true
        }
    })
EOF
nnoremap ,t <cmd>lua require('harpoon.mark').add_file()<cr>
nnoremap ,j <cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>

nnoremap ,f <cmd>lua require('harpoon.ui').nav_file(1)<cr>
nnoremap ,d <cmd>lua require('harpoon.ui').nav_file(2)<cr>
nnoremap ,s <cmd>lua require('harpoon.ui').nav_file(3)<cr>
nnoremap ,a <cmd>lua require('harpoon.ui').nav_file(4)<cr>
nnoremap ,r <cmd>lua require('harpoon.ui').nav_file(5)<cr>
nnoremap ,e <cmd>lua require('harpoon.ui').nav_file(6)<cr>
nnoremap ,w <cmd>lua require('harpoon.ui').nav_file(7)<cr>
nnoremap ,q <cmd>lua require('harpoon.ui').nav_file(8)<cr>

nnoremap ,c <cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>
nnoremap ,v :w <bar> lua require("harpoon.tmux").sendCommand(1, 1)<cr>
nnoremap ,x <cmd>lua require("harpoon.tmux").sendCommand(2, 2)<cr>
nnoremap ,z <cmd>lua require("harpoon.tmux").sendCommand(3, 3)<cr>

" Configure UndoTree
nnoremap <leader>u :UndotreeToggle<cr>

" Begin Telescope config ------------------------------
hi! link TelescopeMatching Label " Assigns label color to telesscope match highlighting
lua <<EOF

local ignore_file = vim.fn.expand("~/.config/fd/ignore")

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

require("telescope").setup {
  defaults = {
    preview = {
      hide_on_startup = true,
      filesize_limit = 5
    },
    mappings = {
      i = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<C-j>"] = action_layout.toggle_preview,
      },
      n = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
        ["<C-j>"] = action_layout.toggle_preview,
      },
    },
    path_display = { 'truncate' },
    layout_strategy = 'vertical',
    layout_config = { height = 0.99, width = 0.99, preview_height = 0.5, preview_cutoff = 0 },
    file_ignore_patterns = { "%.png", "%.jpg", "%.bmp", "%.gif", "%.jpeg" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--max-columns=250",
      "--smart-case",
      "--trim",
      "--hidden",
      "--ignore-file", -- showing hidden and using same ignore_file as fd
      ignore_file
    }
  },
  pickers = {
    find_files = {
      -- including hidden and using custom ignore file, not built in ignores based on .gitignore
      find_command = {
        "fd",
        "--type",
        "file",
        "--strip-cwd-prefix",
        "--hidden",
        "--no-ignore",
        "--follow",
        "--ignore-file",
        ignore_file
      }
    },
    live_grep = {
      previewer = false
    },
    lsp_references = {
      show_line = false
    },
    buffers = {
      mappings = {
        i = {
          ["<C-k>"] = "delete_buffer",
        },
        n = {
          ["<C-k>"] = "delete_buffer",
        }
      }
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                     -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('luasnip')
EOF

nnoremap <leader>lM <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>lm <cmd>lua require('telescope.builtin').marks()<cr>

nnoremap <leader>lf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>lb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>lj <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>lJ <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>lk <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>lR <cmd>lua require('telescope.builtin').registers()<cr>

nnoremap <leader>lh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>ll <cmd>lua require('telescope.builtin').resume()<cr>

nnoremap <leader>ls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>lt <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>lT <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
nnoremap <leader>lr <cmd>lua require('telescope.builtin').lsp_references { trim_text = true }<cr>
"nnoremap <leader>lc <cmd>lua require('telescope.builtin').lsp_code_actions()<cr> (replace with telescope select)
nnoremap <leader>ld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>li <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <leader>lq <cmd>lua require('telescope.builtin').diagnostics()<cr>
nnoremap <leader>lgf <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>lgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>lgb <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>lga <cmd>lua require('telescope.builtin').git_branches()<cr>

nnoremap <leader>lx <cmd>lua require('telescope').extensions.luasnip.luasnip{}<cr>
" End Telescope config --------------------------------


" Begin Treesitter config -----------------------------
lua <<EOF
-- vim.g.skip_ts_context_commentstring_module = true

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "astro",
        "bash",
        "comment",
        "c",
        "c_sharp",
        "cpp",
        "css",
        "dockerfile",
        "fish",
        "html",
        "java",
        "javascript",
        "json",
        "lua",
        "prisma",
        "python",
        "regex",
        "ruby",
        "scala",
        "scss",
        "sql",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "yaml",
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
    textobjects = { enable = true },
    autotag = {
        -- autoindent plugin setup
        enable = true
    }
 }

-- Init better treesitter aware commenting
require("ts-comments").setup()
EOF
" End Treesitter config -------------------------------


" Begin LSP and nvim cmp config -----------------------------
set completeopt=menu,menuone,noselect " is this for nvim-cmp?

lua <<EOF
require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = { "omnisharp", "gopls", "eslint", "ruby_lsp", "vtsls" },
}

-- Setup nvim-cmp.
local lspkind = require "lspkind"
lspkind.init()

local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({
        select = true,
        behavior = cmp.ConfirmBehavior.Replace
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'luasnip', keyword_length = 5 },
  }, {
    { name = 'path' },
    { name = 'buffer', keyword_length = 5 },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true, -- do not show text alongside icons
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        path = "[path]",
      }
    })
  },
})

-- Setup LSP Config
local nvim_lsp = require('lspconfig')

  -- Mappings.
local opts = { noremap=true, silent=true }
-- nvim 10 new defaults, [d and ]d in Normal mode map to vim.diagnostic.goto_prev() and vim.diagnostic.goto_next(), respectively. Use these to navigate between diagnostics in the current buffer.
-- <C-W>d (and <C-W><C-D>) in Normal mode map to vim.diagnostic.open_float(). Use this to view information about any diagnostics under the cursor in a floating window.
-- old bindings
-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
-- Keeping these two mapping so that it opens the float by default when going to the diagnostic
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts) nvim 10 default
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end


local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp['omnisharp'].setup {
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}

-- Run `go install golang.org/x/tools/gopls@latest` to install lang server
nvim_lsp['gopls'].setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}

nvim_lsp['ruby_lsp'].setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
  -- https://shopify.github.io/ruby-lsp/editors.html
  -- init_options = {
  --   formatter = 'standard'
  -- }
}

nvim_lsp['eslint'].setup {
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gp', '<cmd>EslintFixAll<CR>', opts)

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities
}

require("lspconfig.configs").vtsls = require("vtsls").lspconfig
nvim_lsp['vtsls'].setup {
    on_attach = function(client, bufnr)

      local buf_map = function(bufnr, mode, lhs, rhs, opts)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
              silent = true,
          })
      end

      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      buf_map(bufnr, "n", "go", ":VtsExec organize_imports<CR>")
      buf_map(bufnr, "n", "<leader>rN", ":VtsExec rename_file<CR>")
      buf_map(bufnr, "n", "gp", ":VtsExec add_missing_imports<CR>")
      on_attach(client, bufnr)
    end,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = capabilities,
  settings = {
    typescript = {
      preferences = {
        importModuleSpecifier = "non-relative"
      }
    }
  }
}

EOF
" End LSP and nvim cmp config -----------------------------

" Conform Setup ---------------------------------------
lua <<EOF
require("conform").setup({
  formatters_by_ft = {
    -- Conform will run the first available formatter
    html = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    eruby = { "erb_format" },
    ["*"] = { "trim_whitespace" },
  },
   default_format_opts = {
    lsp_format = "first",
  },
})
EOF
nnoremap <leader>f <cmd>lua require('conform').format()<cr>
" End Conform Setup ---------------------------------

