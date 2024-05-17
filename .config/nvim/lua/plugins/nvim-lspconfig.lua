local Plugin = {'neovim/nvim-lspconfig'}

Plugin.dependencies = {
  {'hrsh7th/cmp-nvim-lsp'}
}

Plugin.cmd = 'LspInfo'

Plugin.event = {'BufReadPre', 'BufNewFile'}

Plugin.config = function()
  local lsp_zero = require('lsp-zero')
  lsp_zero.extend_lspconfig()

  lsp_zero.on_attach(function(client, bufnr)
    -- See :help lsp-zero-keybindings
    lsp_zero.default_keymaps({buffer = bufnr})
  end)

  require('lspconfig').clangd.setup({})
end

return Plugin
