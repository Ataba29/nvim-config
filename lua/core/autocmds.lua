-- lua/core/autocmds.lua - Autocommands

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  desc = "Remove trailing whitespace on save",
  group = augroup("remove-trailing-whitespace", { clear = true }),
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Auto-resize splits when Vim gets resized
autocmd("VimResized", {
  desc = "Auto-resize splits when Vim gets resized",
  group = augroup("resize-splits", { clear = true }),
  pattern = "*",
  command = "wincmd =",
})

-- Go to last location when opening a buffer
autocmd("BufReadPost", {
  desc = "Go to last location when opening a buffer",
  group = augroup("last-location", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  desc = "Close some filetypes with <q>",
  group = augroup("close-with-q", { clear = true }),
  pattern = {
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Auto create directories when saving files
autocmd({ "BufWritePre" }, {
  desc = "Auto create directories when saving files",
  group = augroup("auto-create-dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  desc = "Check if we need to reload the file when it changed",
  group = augroup("checktime", { clear = true }),
  command = "checktime",
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
  desc = "Fix conceallevel for json files",
  group = augroup("json-conceal", { clear = true }),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})