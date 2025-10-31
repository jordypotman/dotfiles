-- Highly extendable fuzzy finder over lists.
local is_unix = vim.fn.has('unix') == 1 or vim.fn.has('mac') == 1
return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      enabled = is_unix
    }
  },
  cmd = { 'Telescope' },
  keys = function() return require('config.keymaps').telescope.get_keys() end,
  config = function()
    if is_unix then
      require('telescope').load_extension('fzf')
    end
  end
}
