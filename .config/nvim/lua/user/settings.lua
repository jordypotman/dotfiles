local settings = {}

function settings.setup()
  -- Enable line numbering.
  vim.opt.number = true

  -- Enable the use of the mouse in all modes.
  vim.opt.mouse = 'a'

  -- Ignore case in search patterns unless the pattern contains upper case
  -- characters.
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Disable highlighting all matches of a previous search pattern.
  vim.opt.hlsearch = false

  -- Turn wrapping of lines longer than the width of the window off.
  vim.opt.wrap = false

  -- Always draw the signcolumn.
  vim.opt.signcolumn = 'yes'

  -- Open new split panes to the right of or below the current pane.
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- Don't show the mode, since it's already in the status line.
  vim.opt.showmode = false

  -- Complete till longest common string, showing all matches in wildmenu on
  -- first press of <Tab>, complete the next full match on second press of <Tab>.
  -- See: http://stackoverflow.com/questions/526858
  vim.opt.wildmode = 'longest:full,full'
end

return settings
