-- Seamless navigation between tmux panes and vim splits.
return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = function() return require('config.keymaps').vim_tmux_navigator.get_keys() end
}
