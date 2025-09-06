-- lua/core/keymaps.lua - Global keymaps

local keymap = vim.keymap

-- Better escape
keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- Clear search highlights
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Buffer management
keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
keymap.set("n", "<leader>bD", ":bdelete!<CR>", { desc = "Force delete buffer" })

-- Stay in indent mode
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move text up" })
keymap.set("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move text down" })
keymap.set("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move text up" })

-- Better paste
keymap.set("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Center screen on search
keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Center screen on page navigation
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up" })

-- Save and quit shortcuts
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all without saving" })

-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Terminal mode keymaps
keymap.set("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Terminal go to left window" })
keymap.set("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Terminal go to lower window" })
keymap.set("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Terminal go to upper window" })
keymap.set("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Terminal go to right window" })

-- Better command mode
keymap.set("c", "<C-j>", "<Down>", { desc = "Next command in history" })
keymap.set("c", "<C-k>", "<Up>", { desc = "Previous command in history" })