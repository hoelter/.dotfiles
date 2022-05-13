" Dependencies that should be installed for config to fully work
" neovim
" lf
" [ripgrep](https://github.com/BurntSushi/ripgrep)
" [FD](https://github.com/sharkdp/fd)
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
"set numberwidth=20 " make code more centered
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nofoldenable
set nowrap
set colorcolumn=80
set updatetime=750 " Unsure of the significance of this, default is 4000
set showmatch " show matching brackets when indicator is over them
"set cursorline " highlights entire cursor line when turned on
set nomodeline " turns off looking for vim commands in files to auto execute

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

"" Nice menu when tab completing `:find *.py`
set wildmode=longest,list,full
set path+=** " Allow recursive searching of entire project dir using :find

"" Ignore files
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

if has('mouse')
  set mouse=a
endif

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


augroup locallist
    autocmd!
	autocmd DiagnosticChanged * lua vim.diagnostic.setloclist({ open = false })
augroup END

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

" Toggle quickfix and local list
nnoremap <expr> <C-q> empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen<CR>' : ':cclose<CR>'
nnoremap <expr> <leader>q empty(filter(getwininfo(), 'v:val.loclist')) ? ':lopen<CR>' : ':lclose<CR>'

" Replace selected section maintaining the original yank in the register
xnoremap <leader>p "_dP

" Paste from clipboard, avoids autoindent issues
"nnoremap <leader>P "+p

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

" center screen while searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Git Status
nnoremap <leader>gs :Git<CR>
" vim fugitive quickfix commits for current file
nnoremap <leader>gh :0Gclog<CR>
" Git Blame
nnoremap <leader>gb :Git blame<CR>
" Git push to origin current branch
nnoremap <leader>gp :Git -c push.default=current push<CR>
" Git add all and commit
nnoremap <leader>gc :Git ca<CR>
" Better potential diffing
" https://github.com/tpope/vim-fugitive/issues/132#issuecomment-649516204

" Delete all buffers but current buffer
"nnoremap <leader>bd :%bd <bar> e# <bar> bd#<CR> <bar> '"

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
"
" Open word under cursor (primarily for urls)
"nnoremap <leader>o "oyiW :!fish -c $'open "@o"'<CR><CR>
nnoremap <leader>o "oyiW :exec("!fish -c 'open " . shellescape('<C-R>o', 1) . "'")<CR><CR>
":exec("! clear && echo " . shellescape(g:input, 1))

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

" Lf vim
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'

" honor .editorconfig file settings
Plug 'editorconfig/editorconfig-vim'

" Theme  
Plug 'arcticicestudio/nord-vim', {'branch': 'develop'}

" Neovim native lsp
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
" cmp-extra completion info
Plug 'onsails/lspkind.nvim'
" Snippet Plugin
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Git helper
Plug 'tpope/vim-fugitive'

" Auto comement
Plug 'tpope/vim-commentary'
"Context aware front-end comment help
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" Typescript plugins
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Omnisharp Specific Decompilation Support
Plug 'hoelter/omnisharp-extended-lsp.nvim'

" Log File syntax highlighting
Plug 'mtdl9/vim-log-highlighting'

" Octo Github Interactions
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'pwntester/octo.nvim'

" Align text into tables
Plug 'junegunn/vim-easy-align'
" Centering Vim
Plug 'junegunn/goyo.vim'

" Marks alternative
"Plug 'ThePrimeagen/harpoon'
" TODO: Setup keybindings for harpoon

" Call Hierarchy for LSP
" Plug 'ldelossa/litee.nvim'
" Plug 'ldelossa/litee-calltree.nvim'

" Nvim debugger
" Plug 'mfussenegger/nvim-dap'

" Indentation guides
Plug 'lukas-reineke/indent-blankline.nvim'

" Auto Indent
Plug 'windwp/nvim-ts-autotag'

" Surround Action
Plug 'tpope/vim-surround'

call plug#end()

"--------------------------------------------------------------------------
" Custom Language Settings (post treesitter)
"--------------------------------------------------------------------------

" Filetype settings
augroup filetype_settings
  autocmd!
  autocmd Filetype xml setlocal expandtab ts=2 sw=2
  autocmd Filetype vim setlocal expandtab ts=2 sw=2
  autocmd Filetype markdown setlocal expandtab ts=2 sw=2
  autocmd Filetype text setlocal expandtab ts=2 sw=2
  autocmd Filetype json setlocal expandtab ts=2 sw=2
  
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
  autocmd FileType cs nnoremap <buffer> <leader>{ o{<esc>o}<esc>O
  autocmd FileType cs nnoremap <leader>ld <cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>
  "autocmd FileType cs nnoremap <buffer> gmI ?\(public class\<bar>public interface\)<cr><cmd>nohlsearch<cr>$<cmd>:lua vim.lsp.buf.definition()<CR><C-o>
  autocmd BufNewFile,BufRead *.cshtml setlocal filetype=html

augroup END

"--------------------------------------------------------------------------
" Plugin Settings
"--------------------------------------------------------------------------

" Load color scheme after plugins
let g:nord_uniform_diff_background = 1
colorscheme nord


" Lf Settings
" https://github.com/ptzz/lf.vim
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
"let g:lf_replace_netrw = 1
let g:lf_map_keys = 0
nnoremap <leader>d :Lf<CR>


" Start interactive EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Goyo
" Consider removing height margins: https://github.com/junegunn/goyo.vim/issues/100#issuecomment-588226459
let g:goyo_width=100
let g:goyo_height=100
let g:goyo_linenr=1
nnoremap <leader>z :Goyo<CR>

" Indent blankline settings
lua <<EOF
    require("indent_blankline").setup {
    show_current_context = true
}
EOF

" Load luasnip vscode like snippets
lua <<EOF
    require("luasnip.loaders.from_vscode").lazy_load()
EOF

" Begin Telescope config ------------------------------
lua <<EOF

local ignore_file = vim.fn.expand("~/.config/fd/ignore")

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
-- Wasn't working as an override
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
    layout_config = { height = 0.99, width = 0.99, preview_height = 0.75 },
    -- wrap_results = true,
    -- path_display = { shorten = 2 },
    -- layout_strategy = 'horizontal',
    -- layout_config = { height = 0.99, preview_width = 0.8, width = 0.99 },
    file_ignore_patterns = { "%.png", "%.jpg", "%.bmp", "%.gif", "%.jpeg" },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
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
        "--ignore-file",
        ignore_file
      }
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
    --lsp_references = { -- doesn't work as expected
    --  show_line = false
    --},
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
nnoremap <leader>lk <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>lR <cmd>lua require('telescope.builtin').registers()<cr>
" nnoremap <leader>lp <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>lh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>ll <cmd>lua require('telescope.builtin').resume()<cr>

nnoremap <leader>ls <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>lt <cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<cr>
nnoremap <leader>lT <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>
nnoremap <leader>lr <cmd>lua require('telescope.builtin').lsp_references { trim_text = true }<cr>
nnoremap <leader>lc <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>ld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>lq <cmd>lua require('telescope.builtin').diagnostics()<cr>
nnoremap <leader>lgf <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>lgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>lgb <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>lga <cmd>lua require('telescope.builtin').git_branches()<cr>

nnoremap <leader>lS <cmd>lua require('telescope').extensions.luasnip.luasnip{}<cr>
" End Telescope config --------------------------------



" Begin Treesitter config -----------------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "comment",
        "c_sharp",
        "css",
        "dockerfile",
        "fish",
        "html",
        "javascript",
        "json",
        "lua",
        "python",
        "regex",
        "scss",
        "tsx",
        "typescript",
        "vim",
        "yaml",
    },
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
    context_commentstring = {
        enable = true
    },
    autotag = {
        -- autoindent plugin setup
        enable = true
    }
 }
EOF
" End Treesitter config -------------------------------




" Begin LSP and nvim cmp config -----------------------------
set completeopt=menu,menuone,noselect

lua <<EOF
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
      { name = 'luasnip' },
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
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gsd', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ci', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>co', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end



  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Setup null ls
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach,
    capabilities = capabilities
  })

  -- Omnisharp
  local pid = vim.fn.getpid()
  local omnisharp_bin = vim.fn.expand('~/.local/omnisharp/run')
  nvim_lsp['omnisharp'].setup {
    handlers = {
      ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
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

      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false

      local ts_utils = require("nvim-lsp-ts-utils")
      ts_utils.setup({})
      ts_utils.setup_client(client)
      buf_map(bufnr, "n", "go", ":TSLspOrganize<CR>")
      buf_map(bufnr, "n", "<leader>rN", ":TSLspRenameFile<CR>")
      buf_map(bufnr, "n", "gp", ":TSLspImportAll<CR>")
      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  })

EOF
" End LSP and nvim cmp config -----------------------------



" Begin nvim-dap config -----------------------------------
"nnoremap <F5> <cmd>lua require('dap').continue()<cr>
"nnoremap <leader>b <cmd>lua require('dap').toggle_breakpoint()<cr>
"
"lua <<EOF
"local dap = require("dap")
"local netcoredgb_bin = vim.fn.expand('~/.local/netcoredbg/netcoredbg')
"
"dap.adapters.coreclr = {
"  type = 'executable',
"  command = netcoredgb_bin,
"  args = {'--interpreter=vscode'}
"}
"
"dap.configurations.cs = {
"  {
"    type = "coreclr",
"    name = "launch - netcoredbg",
"    request = "launch",
"    program = function()
"        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
"    end,
"  },
"}
"EOF
" End nvim-dap config -------------------------------------


