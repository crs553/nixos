local on_attach = function(_, bufnr)
      local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
      end


  map('n','<leader>r', vim.lsp.buf.rename, "Rename")
  map('n','<leader>a', vim.lsp.buf.code_action, "Code Action")
  map('n','gd', vim.lsp.buf.definition,"Go to definition")
  map('n','gD', vim.lsp.buf.declaration,"Go to declaration")
  map('n','gI', vim.lsp.buf.implementation, "Go to implementation")
  map('n','<leader>D', vim.lsp.buf.type_definition, "Go to type definition")

  map('n','gr', require('telescope.builtin').lsp_references, "LSP references")
  map('n','<leader>s', require('telescope.builtin').lsp_document_symbols, "LSP Document symbols")
  map('n','<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, "LSP Dynamic Workspace Symbols")

  map('n','K', vim.lsp.buf.hover, "Hover")

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


-- Nix language server
vim.lsp.config["lua_ls"] = {
   cmd = { 'lua-language-server' },

   -- Filetypes to automatically attach to.
   filetypes = { 'lua' },
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
  filetypes = { "lua" },
}
vim.lsp.enable('lua_ls')
vim.lsp.config['nixd'] =  {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "nixd" },
    filetypes = { "nix" },
}
vim.lsp.enable('nixd')
