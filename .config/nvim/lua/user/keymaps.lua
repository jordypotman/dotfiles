local keymaps = {}

keymaps.general = {}

function keymaps.general.setup()
  -- Set mapleader hefore any other mappings because it's value is used at the
  -- moment a mapping is defined.
  vim.g.mapleader = ' '

  -- Show the path of the current file. Useful when the file path in the status
  -- line gets truncated.
  -- From: https://github.com/wincent/wincent/blob/30ea9601ddd061ead644504570546ec0435b77aa/aspects/nvim/files/.config/nvim/plugin/mappings/leader.lua#L13-L15
  vim.keymap.set('n', '<leader>p', ":echo expand('%')<cr>")
end

keymaps.dap = {}

function keymaps.dap.setup()
  local dap = require('dap')
  vim.keymap.set('n', '<leader>dc', dap.continue, {})
  vim.keymap.set('n', '<leader>ds', dap.step_into, {})
  vim.keymap.set('n', '<leader>dn', dap.step_over, {})
  vim.keymap.set('n', '<leader>do', dap.step_out, {})
  vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {})
end

keymaps.gitsigns = {}

function keymaps.gitsigns.setup(bufnr)
  local gitsigns = require('gitsigns')

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal({']c', bang = true})
    else
      gitsigns.nav_hunk('next')
    end
  end)

  map('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal({'[c', bang = true})
    else
      gitsigns.nav_hunk('prev')
    end
  end)

  -- Actions
  map('n', '<leader>hs', gitsigns.stage_hunk)
  map('n', '<leader>hr', gitsigns.reset_hunk)
  map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
  map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
  map('n', '<leader>hS', gitsigns.stage_buffer)
  map('n', '<leader>hu', gitsigns.undo_stage_hunk)
  map('n', '<leader>hR', gitsigns.reset_buffer)
  map('n', '<leader>hp', gitsigns.preview_hunk)
  map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
  map('n', '<leader>hd', gitsigns.diffthis)
  map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
  map('n', '<leader>td', gitsigns.toggle_deleted)

  -- Text object
  map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

keymaps.telescope = {}

function keymaps.telescope.setup()
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
end

function keymaps.setup()
  keymaps.general.setup()
end

return keymaps
