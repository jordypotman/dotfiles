-- Configs for the Nvim LSP client.
-- Based on: https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim.html
local Plugin = {'neovim/nvim-lspconfig'}

Plugin.dependencies = {
  {'hrsh7th/cmp-nvim-lsp'},
  {'williamboman/mason-lspconfig.nvim'}
}

Plugin.cmd = 'LspInfo'

Plugin.event = {'BufReadPre', 'BufNewFile'}

function Plugin.config()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(function(client, bufnr)
    -- See :help lsp-zero-keybindings
    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  --require('lspconfig').clangd.setup({})
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
end

return Plugin
