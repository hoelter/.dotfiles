" Dependencies that should be installed for config to fully work
" neovim
" ranger
" [ripgrep](https://github.com/BurntSushi/ripgrep)
" [FD](https://github.com/sharkdp/fd)
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
"set numberwidth=2 " make code more centered
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nofoldenable
set nowrap
set colorcolumn=80
set updatetime=50 " Unsure of the significance of this, default is 4000

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

"" Nice menu when tab completing `:find *.py`
"set wildmode=longest,list,full
"set path+=** " Allow recursive searching of entire project dir using :find
"
"" Ignore files
"set wildignore+=*_build/*
"set wildignore+=**/coverage/*
"set wildignore+=**/node_modules/*
"set wildignore+=**/android/*
"set wildignore+=**/ios/*
"set wildignore+=**/.git/*
"set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
"set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
"set wildignore+=*.spl                            " compiled spelling word lists
"set wildignore+=*.DS_Store                       " OSX bullshit
"set wildignore+=*.luac                           " Lua byte code
"set wildignore+=*.pyc                            " Python byte code
"set wildignore+=*.orig                           " Merge resolution files


" Neovim built in quick highlight on yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 75})
augroup END


" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.regname ==# '+' | call system('cat |' . s:clip, @+) | endif
    augroup END
endif


" Quickfix list toggle support
let g:hoelter_qf_l = 0
let g:hoelter_qf_g = 0

augroup fixlist
    autocmd!
    autocmd BufWinEnter quickfix call SetQFControlVariable()
    autocmd BufWinLeave * call UnsetQFControlVariable()
augroup END

fun! SetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:hoelter_qf_l = 1
    else
        let g:hoelter_qf_g = 1
    end
endfun

fun! UnsetQFControlVariable()
    if getwininfo(win_getid())[0]['loclist'] == 1
        let g:hoelter_qf_l = 0
    else
        let g:hoelter_qf_g = 0
    end
endfun

fun! ToggleQFList(global)
    if a:global
        if g:hoelter_qf_g == 1
            cclose
        else
            copen
        end
    else
        echo 'Locallist toggled'
        if g:hoelter_qf_l == 1
            lclose
        else
            lopen
        end
    endif
endfun

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
nnoremap <leader>j :lnext<CR>zz
nnoremap <leader>k :lprev<CR>zz

nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <leader>q :call ToggleQFList(0)<CR>

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

" move visually selected line of code up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" mark executable
nnoremap <leader>x :!chmod +x %<CR>

" to quickly paste from clipboard without strange indents, automate in future
set pastetoggle=<F10>

" alt - s for new tmux window session picker
nnoremap <silent> <M-s> :silent !tmux neww tmux-sessionizer<CR>

" center screen while searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Git Status
nnoremap <leader>gs :G<CR>
" vim fugitive quickfix commits for current file
nnoremap <leader>gh :0Gclog<CR>
" Git Blame
nnoremap <leader>gb :G blame<CR>

nnoremap <leader>bd :%bd <bar> e# <bar> bd#<CR> <bar> '"

" toggle local spell check
nnoremap <F6> :setlocal spell! spell?<CR>

" Remove search highlight
nnoremap <leader>/ :nohlsearch<CR>
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
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Ranger vim dependency
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" honor .editorconfig file settings
Plug 'editorconfig/editorconfig-vim'

" Theme
Plug 'arcticicestudio/nord-vim'

" Neovim native lsp
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" Git helper
Plug 'tpope/vim-fugitive'

" Auto comement
Plug 'tpope/vim-commentary'

" Typescript plugins
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Log File syntax highlighting
Plug 'mtdl9/vim-log-highlighting'

call plug#end()

"--------------------------------------------------------------------------
" Custom Language Settings (post treesitter)
"--------------------------------------------------------------------------

" Filetype settings
augroup filetype_settings
  autocmd!
  "autocmd BufNewFile,BufRead *.yml,*.yaml,*.txt,*.md,*.csproj,*.json setlocal expandtab ts=2 sw=2
  "autocmd BufNewFile,BufRead *.yml,*.yaml,*.txt,*.md,*.csproj,*.json setlocal expandtab ts=2 sw=2
  autocmd BufNewFile,BufRead *.cshtml setlocal filetype=html

  autocmd Filetype xml,vim setlocal expandtab ts=2 sw=2
  autocmd Filetype vim setlocal expandtab ts=2 sw=2
  autocmd Filetype markdown setlocal spell expandtab ts=2 sw=2
  autocmd Filetype text setlocal spell expandtab ts=2 sw=2
  
  " Stop yaml comment causing indent
  autocmd Filetype yaml setlocal indentkeys-=0#
  autocmd Filetype gitconfig setlocal noexpandtab
  "autocmd BufNewFile,BufRead *.yml,*.yaml setlocal indentkeys-=0#
  
  " spell chek for git commits
  autocmd FileType gitcommit setlocal spell

  " Jump to previous,next method name
  autocmd FileType cs noremap <buffer> [m k?\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b
  autocmd FileType cs noremap <buffer> ]m /\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b
  autocmd FileType cs nnoremap <buffer> <leader>lR ?\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b<cmd>Telescope lsp_references<cr>
  autocmd FileType cs nnoremap <buffer> gI ?\(public class\<bar>public interface\)<cr><cmd>nohlsearch<cr>$<cmd>:lua vim.lsp.buf.definition()<CR><C-o>
  "autocmd FileType cs nnoremap <buffer> gmI ?\(public class\<bar>public interface\)<cr><cmd>nohlsearch<cr>$<cmd>:lua vim.lsp.buf.definition()<CR><C-o>
augroup END

"--------------------------------------------------------------------------
" Plugin Settings
"--------------------------------------------------------------------------

" Load color scheme after plugins
colorscheme nord




" Ranger Settings
" https://github.com/francoiscabrol/ranger.vim
let g:ranger_replace_netrw = 1
let g:ranger_map_keys = 0 " unmap default ranger binding of <leader> f
nnoremap <leader>ld :Ranger<CR>




" Begin Telescope config ------------------------------
lua <<EOF

local ignore_file = vim.fn.expand("~/.config/fd/ignore")

-- Wasn't working as an override
--local actions = require("telescope.actions")
--local transform_mod = require('telescope.actions.mt').transform_mod
--
--local move_up = transform_mod({
--  move_up = function(_)
--    return vim.cmd ":normal! zt"
--  end
--})
--    mappings = {
--      i = {
--        ["<CR>"] = actions.select_default + move_up
--      },
--      n = {
--        ["<CR>"] = actions.select_default + move_up
--      },
--    },

require("telescope").setup {
  defaults = {
    preview = {
      -- Consider undoing in the future: https://github.com/nvim-telescope/telescope.nvim/issues/1616
      treesitter = false
    },
    layout_strategy = 'vertical',
    layout_config = { height = 0.99, preview_height = 0.7 },
    vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--ignore-file", -- showing hidden and using same ignore_file as fd
        ignore_file
    } 
  },
  pickers = {
    find_files = {
        -- including hidden and using custom ignore file, not built in ignores based on .gitignore
        find_command = { "fd", "--type", "file", "--hidden", "--no-ignore", "--ignore-file", ignore_file } 
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
    }
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
EOF

nnoremap <leader>lf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>lg <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>lb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>lj <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>lk <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
" nnoremap <leader>lp <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>lh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>ll <cmd>lua require('telescope.builtin').resume()<cr>

nnoremap <leader>ls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>lt <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>lT <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
nnoremap <leader>lr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>lc <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>lD <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>lq <cmd>lua require('telescope.builtin').diagnostics()<cr>
" End Telescope config --------------------------------




" Begin Treesitter config -----------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    highlight = {
        enable = true,              -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
        disable = { 'yaml' }
    },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
 }
EOF
" End Treesitter config -------------------------------




" Begin LSP and nvim cmp config -----------------------------
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }), -- default is <C-b>, changed for tmux
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
 --  cmp.setup.cmdline('/', {
 --    sources = {
 --      { name = 'buffer' }
 --    }
 --  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })




-- Setup LSP Config
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end



  -- Setup null ls
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
  })

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Csharp-ls (Maybe use in the future, omnisharp is better right now)
  --nvim_lsp['csharp_ls'].setup {
  --  on_attach = on_attach,
  --  flags = {
  --    debounce_text_changes = 150,
  --  },
  --  capabilities = capabilities
  --}

  -- Omnisharp
  local pid = vim.fn.getpid()
  local omnisharp_bin = vim.fn.expand('~/.local/omnisharp/run')
  nvim_lsp['omnisharp'].setup {
    cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }

-- Typescript/linting
  nvim_lsp['tsserver'].setup({
    on_attach = function(client, bufnr)

      local buf_map = function(bufnr, mode, lhs, rhs, opts)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
              silent = true,
          })
      end

      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup({})
      ts_utils.setup_client(client)
      buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
      buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
      buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  })

EOF
" End LSP and nvim cmp config -----------------------------
