-- lua/plugins/tools/toggleterm.lua - Terminal integration

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  keys = {
    { "<leader>ts", "<cmd>ToggleTerm<CR>", desc = "[T]oggle [S]hell" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "[T]oggle [H]orizontal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "[T]oggle [V]ertical" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "[T]oggle [F]loat" },
    { "<leader>tg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "[T]oggle [G]it" },
    { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<CR>", desc = "[T]oggle [P]ython" },
  },
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<leader>ts]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      auto_scroll = true,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
      winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
          return term.name
        end
      },
    })

    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    local Terminal = require("toggleterm.terminal").Terminal

    -- LazyGit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end

    -- Python REPL terminal
    local python = Terminal:new({
      cmd = "python",
      direction = "horizontal",
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _PYTHON_TOGGLE()
      python:toggle()
    end

    -- Node REPL terminal
    local node = Terminal:new({ cmd = "node", hidden = true })

    function _NODE_TOGGLE()
      node:toggle()
    end

    -- HTOP terminal
    local htop = Terminal:new({ cmd = "htop", hidden = true })

    function _HTOP_TOGGLE()
      htop:toggle()
    end
  end,
}