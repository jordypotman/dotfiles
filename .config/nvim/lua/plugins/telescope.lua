-- Highly extendable fuzzy finder over lists.
local Plugin = { 'nvim-telescope/telescope.nvim' }
local is_unix = vim.fn.has('unix') == 1 or vim.fn.has('mac') == 1

Plugin.branch = '0.1.x'

Plugin.dependencies = {
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    enabled = is_unix
  }
}

Plugin.cmd = { 'Telescope' }

function Plugin.init()
  require('user.keymaps').telescope.setup()
end

function Plugin.config()
  if is_unix then
    require('telescope').load_extension('fzf')
  end
end

return Plugin
