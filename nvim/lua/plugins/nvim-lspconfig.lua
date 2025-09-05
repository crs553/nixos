-- Innstall plugins: mason.nvim, nvim-lspconfig
return {
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- ensure_installed = { "pylsp", "marksman", "bashls", "lua_ls", "rust_analyzer", "harper_ls" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- autocompletion
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      -- lua
      lspconfig.lua_ls.setup({ capabilites = capabilities })

      -- python
      lspconfig.pylsp.setup({
        capabilites = capabilities,
        plugins = {
          black = { enabled = true },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
        }
      })

      -- nixd
      lspconfig.nixd.setup({ capabilites = capabilities })
      -- markdown
      lspconfig.marksman.setup({
        capabilities = capabilities,
        root_dir = function(fname)
          local util = require('lspconfig.util')

          -- Try to find a `.git`/`.marksman.toml` folder
          local root = util.root_pattern('.git', '.marksman.toml')(fname)
          if root then
            --print("📁 Marksman: using project root:", root)
            return root
          end

          -- If that fails, but file is inside `~/Documents/notes`, treat it as project root
          local cwd = vim.fn.getcwd()
          if vim.endswith(cwd, 'notes') then
            --print("📁 Marksman: using ~/Documents/notes as root:", cwd)
            return cwd
          end

          -- Otherwise, let Marksman run in single-file mode
          print("🚧 Marksman: no root_dir found, entering single-file mode (returned nil)")
          return nil
        end
      })
      -- bash
      lspconfig.bashls.setup({ capabilities = capabilities })

      -- go lsp
      lspconfig.gopls.setup({ capabilities = capabilities })

      -- rust
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = {
              enable = true,
              command = "clippy",
            }
          },
        },

      })


      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require('lint').linters_by_ft = { python = { 'pylint' } }
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        callback = function() require('lint').try_lint() end
      })
    end,
  },
  {
    'rshkarin/mason-nvim-lint',
    dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-lint' },
    config = function()
      require('mason-nvim-lint').setup({ automatic_installation = true })
    end
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = { python = { 'isort', 'black' } },
    }
  },
  {
    'zapling/mason-conform.nvim',
    dependencies = { 'williamboman/mason.nvim', 'stevearc/conform.nvim' },
    config = function()
      require('mason-conform').setup({ ignore_install = {} })
    end
  },
}
