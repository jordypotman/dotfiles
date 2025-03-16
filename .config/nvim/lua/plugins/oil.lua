-- Neovim file explorer: edit your filesystem like a buffer.
return {
  'stevearc/oil.nvim',
  opts = {
    keymaps = {
      ['<C-h>'] = false,
      ['<C-s>'] = 'actions.select_split',
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-l>'] = false,
      ['<C-r>'] = 'actions.refresh'
    }
  },
  init = function()
    vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
  end
}
