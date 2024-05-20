-- Seamless navigation between tmux panes and vim splits.
local Plugin = { 'christoomey/vim-tmux-navigator' }

Plugin.cmd = {
  'TmuxNavigateLeft',
  'TmuxNavigateDown',
  'TmuxNavigateUp',
  'TmuxNavigateRight',
  'TmuxNavigatePrevious',
}

Plugin.keys = {
  { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
  { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
  { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
  { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
  { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
}

return Plugin
