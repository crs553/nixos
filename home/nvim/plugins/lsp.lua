local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

---------------------------------------------------------------------
-- Lua LS
---------------------------------------------------------------------
vim.lsp.config["lua_ls"] = {
  cmd = { 'lua-language-server' },
  filetypes = { "lua" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
    diagnostics = {
      globals = { "vim" }, -- <<<<< THIS LINE ALLOWS vim AS GLOBAL
    },
  },
}
vim.lsp.enable("lua_ls")

---------------------------------------------------------------------
-- Nixd
---------------------------------------------------------------------
vim.lsp.config['nixd'] = {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "nixd" },
  filetypes = { "nix" },
}
vim.lsp.enable('nixd')

---------------------------------------------------------------------
-- YAML: yamlls
---------------------------------------------------------------------
vim.lsp.config["yamlls"] = {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/kubernetes.json"] = "/*.k8s.yaml",
        ["https://json.schemastore.org/compose-spec.json"] = "docker-compose*.yaml",
      },
    },
  },
}
vim.lsp.enable("yamlls")

---------------------------------------------------------------------
-- Go: gopls
---------------------------------------------------------------------
vim.lsp.config["gopls"] = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unusedwrite  = true,
      },
      staticcheck = true,
    }
  }
}
vim.lsp.enable("gopls")

---------------------------------------------------------------------
-- Python: pylsp
---------------------------------------------------------------------
vim.lsp.config["pylsp"] = {
  cmd = { "pylsp" },
  filetypes = { "python" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pylsp = {
      plugins = {
        pyflakes = { enabled = true },
        pycodestyle = { enabled = true },

        -- Formatters (enable ONE)
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },

        -- Optional checkers
        pylint = { enabled = false },
        mccabe = { enabled = true },
        rope = { enabled = true },

        -- Enable import sorting
        isort = { enabled = true },
      },
    },
  }
}
vim.lsp.enable("pylsp")

---------------------------------------------------------------------
-- Markdown: marksman
---------------------------------------------------------------------
vim.lsp.config["marksman"] = {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  capabilities = capabilities,
  on_attach = on_attach,
}
vim.lsp.enable("marksman")

---------------------------------------------------------------------
-- LTEX Plus: ltex-ls
---------------------------------------------------------------------
vim.lsp.config["ltex"] = {
  cmd = { "ltex-ls" },
  filetypes = { "tex", "markdown", "org", "txt" },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ltex = {
      language = "en-GB",
      diagnosticSeverity = "information",
      disabledRules = {},
      additionalRules = {
        enablePickyRules = true,
      },
    },
  },
}
vim.lsp.enable("ltex")

---------------------------------------------------------------------
-- Bash/Zsh: bash-language-server
---------------------------------------------------------------------
vim.lsp.config["bashls"] = {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
  capabilities = capabilities,
  on_attach = on_attach,
}
vim.lsp.enable("bashls")
