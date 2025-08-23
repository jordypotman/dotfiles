return {
  -- Base16 for NeoVim.
  {
    'RRethy/base16-nvim',
    lazy = false, -- Make sure main colorscheme is loaded during starup.
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.opt.termguicolors = true
      vim.cmd([[colorscheme base16-tomorrow-night]])
    end,
  },
  -- Pairs of handy bracket mappings.
  { 'tpope/vim-unimpaired', dependencies = 'tpope/vim-repeat' },
  -- Vim sugar for UNIX shell commands such as rm, mv, chmod, mkdir, find, etc.
  { 'tpope/vim-eunuch' },
  -- Automatically adjust 'shiftwidth' and 'expandtab'.
  { 'tpope/vim-sleuth' },
  -- Asynchronous build and test dispatcher.
  { 'tpope/vim-dispatch' },
  -- Easily add, change or delete surrounding parentheses, brackets, quotes, etc.
  { 'tpope/vim-surround', dependencies = 'tpope/vim-repeat' },
  -- Provides pseudo clipboard registers such as '& for the tmux paste buffer.
  { 'kana/vim-fakeclip' },
  -- Highlight the exact differences, based on characters and words.
  { 'rickhowe/diffchar.vim' }
}
