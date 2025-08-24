return {
  -- gitsigns.nvim
  -- https://github.com/lewis6991/gitsigns.nvim
  -- Git integration for buffers.
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
