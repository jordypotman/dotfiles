local options = {}

function options.setup()
  -- Enable line numbering.
  vim.o.number = true

  -- Enable the use of the mouse in all modes.
  vim.o.mouse = 'a'

  -- Ignore case in search patterns unless the pattern contains upper case
  -- characters.
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Disable highlighting all matches of a previous search pattern.
  vim.o.hlsearch = false

  -- Turn wrapping of lines longer than the width of the window off.
  vim.o.wrap = false

  -- Always draw the signcolumn.
  vim.o.signcolumn = 'yes'

  -- Open new split panes to the right of or below the current pane.
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Complete till longest common string, showing all matches in wildmenu on
  -- first press of <Tab>, complete the next full match on second press of <Tab>.
  -- See: http://stackoverflow.com/questions/526858
  vim.o.wildmode = 'longest:full,full'

  -- Start scrolling when the cursor is one line from the top or bottom of the
  -- window.
  vim.o.scrolloff = 1

  -- Start scrolling when the cursor is one column from the left or right of the
  -- windows.
  vim.o.sidescrolloff = 2

  -- Sort diagnostics by severity so signs and virtual text display the
  -- diagnostics with the highest severity.
  vim.diagnostic.config({ severity_sort = true })
end

return options
