-- init.lua - Neovim Configuration Entry Point
-- This is the main configuration file that loads all modules

-- Set leader keys before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configuration
require("core")

-- Load plugin manager and plugins
require("plugins")