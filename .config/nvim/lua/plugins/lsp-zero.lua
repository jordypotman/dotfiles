-- Collection of functions to help setup Neovim's LSP client.
-- Based on: https://lsp-zero.netlify.app/v3.x/guide/lazy-loading-with-lazy-nvim.html
return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  config = false,
  init = function()
    -- Disable automatic setup, we are doing it manually.
    vim.g.lsp_zero_extend_cmp = 0
    vim.g.lsp_zero_extend_lspconfig = 0
  end
}
