-- Collection of functions to help setup Neovim's LSP client.
-- Based on: https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim.html
local Plugin = {'VonHeikemen/lsp-zero.nvim'}

Plugin.branch = 'v3.x'

Plugin.config = false

function Plugin.init()
  -- Disable automatic setup, we are doing it manually.
  vim.g.lsp_zero_extend_cmp = 0
  vim.g.lsp_zero_extend_lspconfig = 0
end

return Plugin
