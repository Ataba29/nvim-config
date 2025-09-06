-- lua/utils/helpers.lua - Utility functions and helpers

local M = {}

-- Check if a plugin is installed
function M.has_plugin(name)
  local ok = pcall(require, name)
  return ok
end

-- Get the operating system
function M.get_os()
  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    return "windows"
  elseif vim.fn.has("unix") == 1 then
    if vim.fn.has("mac") == 1 then
      return "macos"
    else
      return "linux"
    end
  end
  return "unknown"
end

-- Create a keymap with description
function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Create multiple keymaps at once
function M.maps(mappings)
  for _, mapping in ipairs(mappings) do
    local mode, lhs, rhs, opts = unpack(mapping)
    M.map(mode, lhs, rhs, opts)
  end
end

-- Toggle option
function M.toggle_option(option)
  vim.opt[option] = not vim.opt[option]:get()
  print(option .. " is now " .. (vim.opt[option]:get() and "enabled" or "disabled"))
end

-- Get visual selection
function M.get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})
  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

-- Check if buffer is empty
function M.is_buffer_empty()
  return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

-- Check if buffer has words
function M.has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Format file size
function M.format_file_size(size)
  local suffixes = { "B", "KB", "MB", "GB", "TB" }
  local index = 1
  while size > 1024 and index < #suffixes do
    size = size / 1024
    index = index + 1
  end
  return string.format("%.1f %s", size, suffixes[index])
end

-- Get git branch
function M.get_git_branch()
  local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
  if vim.v.shell_error == 0 then
    return branch
  else
    return ""
  end
end

-- Check if file exists
function M.file_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "file"
end

-- Check if directory exists
function M.dir_exists(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory"
end

-- Get project root directory
function M.get_root()
  local root_patterns = { ".git", "lua", "package.json", "Makefile", "go.mod", "cargo.toml", "pyproject.toml" }
  
  local function find_root(path)
    for _, pattern in ipairs(root_patterns) do
      if M.file_exists(path .. "/" .. pattern) or M.dir_exists(path .. "/" .. pattern) then
        return path
      end
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      return nil
    end
    return find_root(parent)
  end

  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  if current_file ~= "" then
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  else
    current_dir = vim.fn.getcwd()
  end

  return find_root(current_dir) or current_dir
end

-- Smart tab function for completion
function M.tab(fallback)
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.locally_jumpable(1) then
    luasnip.jump(1)
  elseif M.has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

-- Smart shift-tab function for completion
function M.shift_tab(fallback)
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.locally_jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

-- Toggle between relative and absolute line numbers
function M.toggle_line_numbers()
  if vim.opt.relativenumber:get() then
    vim.opt.relativenumber = false
    vim.opt.number = true
    print("Absolute line numbers")
  else
    vim.opt.relativenumber = true
    vim.opt.number = true
    print("Relative line numbers")
  end
end

-- Toggle wrap
function M.toggle_wrap()
  M.toggle_option("wrap")
end

-- Toggle spell check
function M.toggle_spell()
  M.toggle_option("spell")
end

-- Close all floating windows
function M.close_floating_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

-- Get LSP clients for current buffer
function M.get_lsp_clients()
  local clients = vim.lsp.get_active_clients()
  local current_buf = vim.api.nvim_get_current_buf()
  local buf_clients = {}
  
  for _, client in ipairs(clients) do
    if vim.lsp.buf_is_attached(current_buf, client.id) then
      table.insert(buf_clients, client.name)
    end
  end
  
  return buf_clients
end

-- Reload configuration
function M.reload_config()
  for name, _ in pairs(package.loaded) do
    if name:match("^core") or name:match("^plugins") or name:match("^utils") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  print("Configuration reloaded!")
end

-- Common terminal commands
M.terminal_commands = {
  lazygit = function()
    if M.get_os() == "windows" then
      return "powershell -c lazygit"
    else
      return "lazygit"
    end
  end,
  
  python = function()
    return "python"
  end,
  
  node = function()
    return "node"
  end,
  
  htop = function()
    if M.get_os() == "windows" then
      return "powershell -c htop"
    else
      return "htop"
    end
  end,
}

-- Notification helper
function M.notify(message, level, title)
  level = level or vim.log.levels.INFO
  title = title or "Neovim"
  
  if M.has_plugin("notify") then
    require("notify")(message, level, { title = title })
  else
    vim.notify(message, level)
  end
end

return M