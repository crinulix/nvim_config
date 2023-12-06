-- Inside Mason install black for python formating

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pylsp", "html" }
})


-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 110
        }
      }
    }
  }
}
lspconfig.lua_ls.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})


--local on_attach = function(_, _)
--  vim.keymap.set('n','<leader>rn', vim.lsp.buf.rename,{})-- '[r]e[n]me')
--  vim.keymap.set('n','<leader>ca', vim.lsp.buf.code_action,{})--  '[c]ode [a]ction')
--  vim.keymap.set('n','gd', vim.lsp.buf.definition,{})--  '[g]et [d]efinition')
--  vim.keymap.set('n','gi', vim.lsp.buf.implementation,{})--  '[g]et [i]mplementation')
--  vim.keymap.set('n','gr', require('telescope.builtin').lsp_references ,{})--  '[g]et [r]eferences')
--  vim.keymap.set('n','K', vim.lsp.hover ,{})--  'Hover Documentation')
--  vim.keymap.set('n','<leader>D', require('telescope.builtin').lsp_type_definitions,{})--  'Type [D]efinition')
--  vim.keymap.set('n','<leader>ds', require('telescope.builtin').lsp_document_symbols,{})--  '[D]ocument [S]ymbols')
--  vim.keymap.set('n','<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,{})--  '[W]orkspace [S]ymbols')
--end
--
--require("lspconfig").lua_ls.setup {
--  on_attach=on_attach
--}
