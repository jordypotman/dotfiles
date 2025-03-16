-- Configs for the Nvim LSP client.
-- Based on: https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim.html
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim' }
  },
  cmd = 'LspInfo',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lsp_zero = require('lsp-zero')
    lsp_zero.extend_lspconfig()

    lsp_zero.on_attach(function(client, bufnr)
      -- See :help lsp-zero-keybindings
      lsp_zero.default_keymaps({ buffer = bufnr })
    end)

    require('mason-lspconfig').setup({
      ensure_installed = {},
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({})
        end,

        lua_ls = function()
          -- Configure lua language server for neovim.
          local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup(lua_opts)
        end
      }
    })

    if vim.fn.executable('clangd') == 1 then
      require('lspconfig').clangd.setup({})
    end

    if vim.fn.executable('tblgen-lsp-server') == 1 then
      require('lspconfig').tblgen_lsp_server.setup({})
    end

    if vim.fn.executable('mlir-lsp-server') == 1 then
      require('lspconfig').mlir_lsp_server.setup({})
    end

    if vim.fn.executable('mlir-pdll-lsp-server') == 1 then
      require('lspconfig').mlir_pdll_lsp_server.setup({})
    end
  end
}
