return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "benfowler/telescope-luasnip.nvim",
  },
    config = function()
      local ignore_file = vim.fn.expand("~/.config/fd/ignore")
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")

      require("telescope").setup({
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
            "--ignore-file",
            ignore_file
          }
        },
        pickers = {
          find_files = {
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
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          }
        }
      })

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('luasnip')

      -- Telescope keymaps
      local keymap = vim.keymap
      keymap.set("n", "<leader>lM", "<cmd>Telescope keymaps<cr>")
      keymap.set("n", "<leader>lm", "<cmd>Telescope marks<cr>")
      keymap.set("n", "<leader>lf", "<cmd>Telescope find_files<cr>")
      keymap.set("n", "<leader>lb", "<cmd>Telescope buffers<cr>")
      keymap.set("n", "<leader>lj", "<cmd>Telescope live_grep<cr>")
      keymap.set("n", "<leader>lJ", "<cmd>Telescope grep_string<cr>")
      keymap.set("n", "<leader>lk", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
      keymap.set("n", "<leader>lR", "<cmd>Telescope registers<cr>")
      keymap.set("n", "<leader>lh", "<cmd>Telescope help_tags<cr>")
      keymap.set("n", "<leader>ll", "<cmd>Telescope resume<cr>")
      keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>")
      keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
      keymap.set("n", "<leader>lT", "<cmd>Telescope lsp_workspace_symbols<cr>")
      keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<cr>")
      keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<cr>")
      keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<cr>")
      keymap.set("n", "<leader>lq", "<cmd>Telescope diagnostics<cr>")
      keymap.set("n", "<leader>lgf", "<cmd>Telescope git_files<cr>")
      keymap.set("n", "<leader>lgc", "<cmd>Telescope git_commits<cr>")
      keymap.set("n", "<leader>lgb", "<cmd>Telescope git_bcommits<cr>")
      keymap.set("n", "<leader>lga", "<cmd>Telescope git_branches<cr>")
      keymap.set("n", "<leader>lx", "<cmd>Telescope luasnip<cr>")
    end,
}