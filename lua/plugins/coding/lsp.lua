-- lua/plugins/coding/lsp.lua - LSP configuration

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "folke/neodev.nvim",
  },
  config = function()
    -- Setup neodev before lspconfig
    require("neodev").setup({})

    -- Import lspconfig plugin
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local mason_lspconfig = require("mason-lspconfig")

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", function()
          if pcall(require, "telescope") then
            vim.cmd("Telescope lsp_references")
          else
            vim.lsp.buf.references()
          end
        end, opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", function()
          if pcall(require, "telescope") then
            vim.cmd("Telescope lsp_definitions")
          else
            vim.lsp.buf.definition()
          end
        end, opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", function()
          if pcall(require, "telescope") then
            vim.cmd("Telescope lsp_implementations")
          else
            vim.lsp.buf.implementation()
          end
        end, opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", function()
          if pcall(require, "telescope") then
            vim.cmd("Telescope lsp_type_definitions")
          else
            vim.lsp.buf.type_definition()
          end
        end, opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", function()
          if pcall(require, "telescope") then
            vim.cmd("Telescope diagnostics bufnr=0")
          else
            vim.diagnostic.setloclist()
          end
        end, opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

        opts.desc = "Format file"
        keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Configure diagnostic signs using the modern method
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = "󰠠 ",
          [vim.diagnostic.severity.INFO] = " ",
        }
      },
    })

    -- Setup mason-lspconfig (this bridges mason and lspconfig)
    mason_lspconfig.setup({
      -- Map mason package names to lspconfig server names
      ensure_installed = {
        "lua_ls",        -- lua-language-server
        "pyright",       -- pyright  
        "ts_ls",         -- typescript-language-server
        "html",          -- html-lsp
        "cssls",         -- css-lsp
        "jsonls",        -- json-lsp
        "yamlls",        -- yaml-language-server
        "clangd",        -- clangd
        "bashls",        -- bash-language-server
      },
      automatic_installation = true,
    })

    -- Configure each server with custom settings
    local server_configs = {
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            completion = {
              callSnippet = "Replace",
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      },
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
            },
          },
        },
      },
      ts_ls = {
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      },
      clangd = {
        cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        },
      },
    }

    -- Setup each server
    for server, config in pairs(server_configs) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end

    -- Setup remaining servers with default config
    local default_servers = { "html", "cssls", "jsonls", "yamlls", "bashls" }
    for _, server in ipairs(default_servers) do
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end
  end,
}