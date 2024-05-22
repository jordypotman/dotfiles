-- Neovim file explorer: edit your filesystem like a buffer.
local Plugin = { 'stevearc/oil.nvim' }

Plugin.opts = {
  keymaps = {
    ['<C-h>'] = false,
    ['<C-s>'] = 'actions.select_split',
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-l>'] = false,
    ['<C-r>'] = 'actions.refresh'
  }
}

function Plugin.init()
  vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
end

return Plugin
