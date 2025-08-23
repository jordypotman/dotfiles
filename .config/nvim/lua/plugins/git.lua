return {
  -- Git decorations.
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('gitsigns').setup {
        on_attach = function(bufnr)
          require('config.keymaps').gitsigns.setup(bufnr)
        end
      }
    end
  },
  -- Git wrapper.
  {
    'tpope/vim-fugitive'
  }
}
