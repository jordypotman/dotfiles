return {
  -- Seamless navigation between tmux panes and vim splits.
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = function() return require('config.keymaps').vim_tmux_navigator.get_keys() end
  },
  -- Provides pseudo clipboard registers such as '& for the tmux paste buffer.
  {
    'kana/vim-fakeclip'
  }
}
