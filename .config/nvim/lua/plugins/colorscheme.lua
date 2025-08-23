-- Base16 for NeoVim.
return {
  'RRethy/base16-nvim',
  lazy = false, -- Make sure main colorscheme is loaded during starup.
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    vim.opt.termguicolors = true
    vim.cmd([[colorscheme base16-tomorrow-night]])
  end,
}
