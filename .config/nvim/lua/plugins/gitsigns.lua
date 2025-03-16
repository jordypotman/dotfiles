-- Git decorations.
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        require('user.keymaps').gitsigns.setup(bufnr)
      end
    }
  end
}
