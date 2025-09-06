-- lua/core/options.lua - Neovim options and settings

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.showmode = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " " }

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Editing
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 250
opt.timeoutlen = 300

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append("c")

-- Performance
opt.lazyredraw = true
opt.ttyfast = true

-- Windows-specific settings
if vim.fn.has("win32") == 1 then
  opt.shell = "powershell"
  opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  opt.shellquote = ""
  opt.shellxquote = ""
end

-- Disable default plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1