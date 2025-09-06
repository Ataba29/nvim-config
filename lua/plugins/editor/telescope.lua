-- lua/plugins/editor/telescope.lua - Fuzzy finder configuration

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Telescope",
  keys = {
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[S]earch [K]eymaps" },
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[S]earch [F]iles" },
    { "<leader>ss", "<cmd>Telescope builtin<cr>", desc = "[S]earch [S]elect Telescope" },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "[S]earch current [W]ord" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "[S]earch by [G]rep" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[S]earch [D]iagnostics" },
    { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "[S]earch [R]esume" },
    { "<leader>s.", "<cmd>Telescope oldfiles<cr>", desc = '[S]earch Recent Files ("." for repeat)' },
    { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "[ ] Find existing buffers" },
    { "<leader>/", function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, desc = "[/] Fuzzily search in current buffer" },
    { "<leader>s/", function()
      require("telescope.builtin").live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, desc = "[S]earch [/] in Open Files" },
    { "<leader>sn", function()
      require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
    end, desc = "[S]earch [N]eovim files" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = require("telescope.actions").cycle_history_next,
            ["<C-p>"] = require("telescope.actions").cycle_history_prev,
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
            ["<C-c>"] = require("telescope.actions").close,
            ["<Down>"] = require("telescope.actions").move_selection_next,
            ["<Up>"] = require("telescope.actions").move_selection_previous,
            ["<CR>"] = require("telescope.actions").select_default,
            ["<C-x>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
            ["<PageUp>"] = require("telescope.actions").results_scrolling_up,
            ["<PageDown>"] = require("telescope.actions").results_scrolling_down,
            ["<Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_worse,
            ["<S-Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_better,
            ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
            ["<M-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            ["<C-l>"] = require("telescope.actions").complete_tag,
            ["<C-_>"] = require("telescope.actions").which_key, -- keys from pressing <C-/>
          },
          n = {
            ["<esc>"] = require("telescope.actions").close,
            ["<CR>"] = require("telescope.actions").select_default,
            ["<C-x>"] = require("telescope.actions").select_horizontal,
            ["<C-v>"] = require("telescope.actions").select_vertical,
            ["<C-t>"] = require("telescope.actions").select_tab,
            ["<Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_worse,
            ["<S-Tab>"] = require("telescope.actions").toggle_selection + require("telescope.actions").move_selection_better,
            ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
            ["<M-q>"] = require("telescope.actions").send_selected_to_qflist + require("telescope.actions").open_qflist,
            ["j"] = require("telescope.actions").move_selection_next,
            ["k"] = require("telescope.actions").move_selection_previous,
            ["H"] = require("telescope.actions").move_to_top,
            ["M"] = require("telescope.actions").move_to_middle,
            ["L"] = require("telescope.actions").move_to_bottom,
            ["<Down>"] = require("telescope.actions").move_selection_next,
            ["<Up>"] = require("telescope.actions").move_selection_previous,
            ["gg"] = require("telescope.actions").move_to_top,
            ["G"] = require("telescope.actions").move_to_bottom,
            ["<C-u>"] = require("telescope.actions").preview_scrolling_up,
            ["<C-d>"] = require("telescope.actions").preview_scrolling_down,
            ["<PageUp>"] = require("telescope.actions").results_scrolling_up,
            ["<PageDown>"] = require("telescope.actions").results_scrolling_down,
            ["?"] = require("telescope.actions").which_key,
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          hidden = true,
        },
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load extensions
    pcall(require("telescope").load_extension, "fzf")
  end,
}