-- lua/plugins/ui/nvim-tree.lua - File explorer configuration

return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>pv", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
    { "<leader>pf", function()
      local view = require("nvim-tree.view")
      if view.is_visible() then
        view.focus()
      else
        vim.cmd("NvimTreeOpen")
      end
    end, desc = "Focus file explorer" },
  },
  config = function()
    -- Disable netrw at the very start
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local nvim_tree = require("nvim-tree")

    nvim_tree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      respect_buf_cwd = true,
      sync_root_with_cwd = true,
      reload_on_bufenter = false,
      hijack_cursor = false,
      hijack_unnamed_buffer_when_opening = false,
      
      view = {
        width = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        adaptive_size = false,
        cursorline = true,
        debounce_delay = 15,
      },
      
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        
        indent_markers = {
          enable = false,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            
            folder = {
              arrow_closed = ">",
              arrow_open = "v",
              default = "📁",
              open = "📂",
              empty = "📁",
              empty_open = "📂",
              symlink = "🔗",
              symlink_open = "🔗",
            },
            
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      
      update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {},
      },
      
      filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { "node_modules", "\\.cache" },
        exclude = {},
      },
      
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        
        remove_file = {
          close_window = true,
        },
      },
      
      trash = {
        cmd = "gio trash",
      },
      
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      
      notify = {
        threshold = vim.log.levels.INFO,
      },
      
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    })
  end,
}