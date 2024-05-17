return {
  -- Base16 for NeoVim.
  {
    "RRethy/base16-nvim",
    lazy = false, -- Make sure main colorscheme is loaded during starup.
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.cmd([[colorscheme base16-tomorrow-night]])
    end,
  },
  -- NeoVim statusline.
  { "nvim-lualine/lualine.nvim", config = true },
  -- Directory viewer.
  { "justinmk/vim-dirvish"},
  -- Pairs of handy bracket mappings.
  { "tpope/vim-unimpaired" },
  -- Vim sugar for UNIX shell commands such as rm, mv, chmod, mkdir, find, etc.
  { "tpope/vim-eunuch" },
  -- Git wrapper.
  { "tpope/vim-fugitive" },
  -- Automatically adjust 'shiftwidth' and 'expandtab'.
  { "tpope/vim-sleuth" },
  -- Asynchronous build and test dispatcher.
  { "tpope/vim-dispatch" },
  -- Easily add, change or delete surrounding parentheses, brackets, quotes, etc.
  { "tpope/vim-surround" },
  -- Provides pseudo clipboard registers such as "& for the tmux paste buffer.
  { "kana/vim-fakeclip" },
  -- Syntax checking and highlighting for OpenCL files.
  { "petRUShka/vim-opencl" },
  -- Highlight the exact differences, based on characters and words.
  { "rickhowe/diffchar.vim" }
}
