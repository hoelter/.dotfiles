" Dependencies that should be installed for config to fully work
" neovim
" ranger
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
set updatetime=50 " Unsure of the significance of this, default is 4000
set showmatch " show matching brackets when indicator is over them
set cursorline " experimenting with this, unsure if I like it

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
nnoremap <leader>bd :%bd <bar> e# <bar> bd#<CR> <bar> '"

" toggle local spell check
nnoremap <F7> :setlocal spell! spell?<CR>

" Remove search highlight
nnoremap <leader>/ :nohlsearch<CR>
"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------
" Automate vim.plug install if it's not yet installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
" cmp-extra completion info
Plug 'onsails/lspkind-nvim'

" Git helper
Plug 'tpope/vim-fugitive'

" Auto comement
Plug 'tpope/vim-commentary'
"Context aware front-end comment help
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

" Typescript plugins
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'

" Log File syntax highlighting
Plug 'mtdl9/vim-log-highlighting'

" Octo Github Interactions
Plug 'kyazdani42/nvim-web-devicons'
Plug 'pwntester/octo.nvim'

" Align text into tables
Plug 'junegunn/vim-easy-align'
" Centering Vim
Plug 'junegunn/goyo.vim'

call plug#end()

"--------------------------------------------------------------------------
" Custom Language Settings (post treesitter)
"--------------------------------------------------------------------------

" Filetype settings
augroup filetype_settings
  autocmd!
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

  " C# Filetype bindings
  autocmd FileType cs noremap <buffer> [m k?\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b
  autocmd FileType cs noremap <buffer> ]m /\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b
  autocmd FileType cs nnoremap <buffer> <leader>lR ?\(public\<bar>private\)<cr><cmd>nohlsearch<cr>f(b<cmd>Telescope lsp_references<cr>
  autocmd FileType cs nnoremap <buffer> gI ?\(public class\<bar>public interface\)<cr><cmd>nohlsearch<cr>$<cmd>:lua vim.lsp.buf.definition()<CR><C-o>
  autocmd FileType cs nnoremap <buffer> <leader>{ o{<esc>o}<esc>O
  "autocmd FileType cs nnoremap <buffer> gmI ?\(public class\<bar>public interface\)<cr><cmd>nohlsearch<cr>$<cmd>:lua vim.lsp.buf.definition()<CR><C-o>
  autocmd BufNewFile,BufRead *.cshtml setlocal filetype=html

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
nnoremap <leader>lD :Ranger<CR>


" Start interactive EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Goyo
" Consider removing height margins: https://github.com/junegunn/goyo.vim/issues/100#issuecomment-588226459
let g:goyo_width=100
let g:goyo_height=100
let g:goyo_linenr=1
nnoremap <leader>z :Goyo<CR>


" Begin Telescope config ------------------------------
lua <<EOF

local ignore_file = vim.fn.expand("~/.config/fd/ignore")

local actions = require("telescope.actions")
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
      -- Consider undoing in the future: https://github.com/nvim-telescope/telescope.nvim/issues/1616
      treesitter = false
    },
    mappings = {
      i = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
      n = {
        ["<C-s>"] = actions.cycle_previewers_next,
        ["<C-a>"] = actions.cycle_previewers_prev,
      },
    },
    path_display = { 'smart' },
    --layout_strategy = 'vertical',
    --layout_config = { height = 0.99, preview_height = 0.7 },
    layout_strategy = 'horizontal',
    layout_config = { height = 0.99, preview_width = 0.54, width = 0.99 },
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
      find_command = {
        "fd",
        "--type",
        "file",
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
EOF

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
nnoremap <leader>lr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <leader>lc <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <leader>ld <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap <leader>lq <cmd>lua require('telescope.builtin').diagnostics()<cr>
nnoremap <leader>lm <cmd>lua require('telescope.builtin').keymaps()<cr>
nnoremap <leader>lgf <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>lgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>lgb <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <leader>lga <cmd>lua require('telescope.builtin').git_branches()<cr>
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
    context_commentstring = {
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
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
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
      ['<CR>'] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
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
    }
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
  buf_set_keymap('n', '<space>Q', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
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




"Octo config ----------------------------------------------
"https://github.com/pwntester/octo.nvim
lua <<EOF
require"octo".setup({
  default_remote = {"upstream", "origin"}; -- order to try remotes
  reaction_viewer_hint_icon = "";         -- marker for user reactions
  user_icon = " ";                        -- user icon
  timeline_marker = "";                   -- timeline marker
  timeline_indent = "2";                   -- timeline indentation
  right_bubble_delimiter = "";            -- Bubble delimiter
  left_bubble_delimiter = "";             -- Bubble delimiter
  github_hostname = "";                    -- GitHub Enterprise host
  snippet_context_lines = 4;               -- number or lines around commented lines
  file_panel = {
    size = 10,                             -- changed files panel rows
    use_icons = true                       -- use web-devicons in file panel
  },
  mappings = {
    issue = {
      close_issue = "<space>ic",           -- close issue
      reopen_issue = "<space>io",          -- reopen issue
      list_issues = "<space>il",           -- list open issues on same repo
      reload = "<C-r>",                    -- reload issue
      open_in_browser = "<C-b>",           -- open issue in browser
      copy_url = "<C-y>",                  -- copy url to system clipboard
      add_assignee = "<space>aa",          -- add assignee
      remove_assignee = "<space>ad",       -- remove assignee
      create_label = "<space>lc",          -- create label
      add_label = "<space>la",             -- add label
      remove_label = "<space>ld",          -- remove label
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    pull_request = {
      checkout_pr = "<space>po",           -- checkout PR
      merge_pr = "<space>pm",              -- merge PR
      list_commits = "<space>pc",          -- list PR commits
      list_changed_files = "<space>pf",    -- list PR changed files
      show_pr_diff = "<space>pd",          -- show PR diff
      add_reviewer = "<space>va",          -- add reviewer
      remove_reviewer = "<space>vd",       -- remove reviewer request
      close_issue = "<space>ic",           -- close PR
      reopen_issue = "<space>io",          -- reopen PR
      list_issues = "<space>il",           -- list open issues on same repo
      reload = "<C-r>",                    -- reload PR
      open_in_browser = "<C-b>",           -- open PR in browser
      copy_url = "<C-y>",                  -- copy url to system clipboard
      add_assignee = "<space>aa",          -- add assignee
      remove_assignee = "<space>ad",       -- remove assignee
      create_label = "<space>lc",          -- create label
      add_label = "<space>la",             -- add label
      remove_label = "<space>ld",          -- remove label
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    review_thread = {
      goto_issue = "<space>gi",            -- navigate to a local repo issue
      add_comment = "<space>ca",           -- add comment
      add_suggestion = "<space>sa",        -- add suggestion
      delete_comment = "<space>cd",        -- delete comment
      next_comment = "]c",                 -- go to next comment
      prev_comment = "[c",                 -- go to previous comment
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      react_hooray = "<space>rp",          -- add/remove 🎉 reaction
      react_heart = "<space>rh",           -- add/remove ❤️ reaction
      react_eyes = "<space>re",            -- add/remove 👀 reaction
      react_thumbs_up = "<space>r+",       -- add/remove 👍 reaction
      react_thumbs_down = "<space>r-",     -- add/remove 👎 reaction
      react_rocket = "<space>rr",          -- add/remove 🚀 reaction
      react_laugh = "<space>rl",           -- add/remove 😄 reaction
      react_confused = "<space>rc",        -- add/remove 😕 reaction
    },
    submit_win = {
      approve_review = "<C-a>",            -- approve review
      comment_review = "<C-m>",            -- comment review
      request_changes = "<C-r>",           -- request changes review
      close_review_tab = "<C-c>",          -- close review tab
    },
    review_diff = {
      add_review_comment = "<space>ca",    -- add a new review comment
      add_review_suggestion = "<space>sa", -- add a new review suggestion
      focus_files = "<leader>e",           -- move focus to changed file panel
      toggle_files = "<leader>b",          -- hide/show changed files panel
      next_thread = "]t",                  -- move to next thread
      prev_thread = "[t",                  -- move to previous thread
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
    },
    file_panel = {
      next_entry = "j",                    -- move to next changed file
      prev_entry = "k",                    -- move to previous changed file
      select_entry = "<cr>",               -- show selected changed file diffs
      refresh_files = "R",                 -- refresh changed files panel
      focus_files = "<leader>e",           -- move focus to changed file panel
      toggle_files = "<leader>b",          -- hide/show changed files panel
      select_next_entry = "]q",            -- move to previous changed file
      select_prev_entry = "[q",            -- move to next changed file
      close_review_tab = "<C-c>",          -- close review tab
      toggle_viewed = "<leader><space>",   -- toggle viewer viewed state
    }
  }
})
EOF
"End Octo config ------------------------------------------
