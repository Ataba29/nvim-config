-- lua/plugins/ui/alpha.lua - Dashboard configuration

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
      "                🚀 Ready to Code! 🚀                ",
      "                                                     ",
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", "<cmd>Telescope find_files <CR>"),
      dashboard.button("e", "  New file", "<cmd>ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles <CR>"),
      dashboard.button("t", "  Find text", "<cmd>Telescope live_grep <CR>"),
      dashboard.button("c", "  Configuration", "<cmd>e $MYVIMRC <CR>"),
      dashboard.button("s", "  Restore Session", "<cmd>SessionRestore <CR>"),
      dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
      dashboard.button("q", "  Quit Neovim", "<cmd>qa<CR>"),
    }

    -- Set footer
    local function footer()
      local total_plugins = #vim.tbl_keys(require("lazy").plugins())
      local datetime = os.date("  %d-%m-%Y   %H:%M:%S")
      local version = vim.version()
      local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

      return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
    end

    dashboard.section.footer.val = footer()

    -- Disable folding on alpha buffer
    dashboard.config.opts.noautocmd = true

    -- Send config to alpha
    alpha.setup(dashboard.config)

    -- Disable statusline in dashboard
    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      desc = "disable statusline for alpha",
      callback = function()
        if vim.o.laststatus == 3 then
          vim.o.laststatus = 0
        end
      end,
    })

    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      desc = "enable statusline after alpha",
      callback = function()
        vim.o.laststatus = 3
      end,
    })
  end,
}