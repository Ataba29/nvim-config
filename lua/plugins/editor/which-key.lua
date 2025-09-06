-- lua/plugins/editor/which-key.lua - Keybinding help

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
        mappings = vim.g.have_nerd_font ~= false,
      },
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
      win = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      filter = function(mapping)
        -- Hide mappings without labels
        return mapping.desc and mapping.desc ~= ""
      end,
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      triggers = {
        { "<auto>", mode = "nxso" },
        { "a", mode = { "n", "v" } },
        { "i", mode = { "n", "v" } },
        { "w", mode = { "n", "v" } },
        { "g", mode = { "n", "v" } },
        { "s", mode = { "n", "v" } },
        { "r", mode = { "n", "v" } },
        { "z", mode = { "n", "v" } },
        { "<leader>", mode = { "n", "v" } },
        { "]", mode = { "n", "v" } },
        { "[", mode = { "n", "v" } },
      },
      disable = {
        bt = {},
        ft = { "TelescopePrompt" },
      },
    })

    -- Add key mappings using the new spec format
    wk.add({
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debug/Diagnostic" },
      { "<leader>f", group = "File/Find" },
      { "<leader>g", group = "Git" },
      { "<leader>gh", group = "Hunks" },
      { "<leader>h", group = "Hop" },
      { "<leader>l", group = "LSP" },
      { "<leader>p", group = "Project" },
      { "<leader>q", group = "Quit/Session" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Terminal/Toggle" },
      { "<leader>u", group = "UI" },
      { "<leader>w", group = "Windows" },
      { "<leader>x", group = "Diagnostics/Quickfix" },
    })
  end,
}