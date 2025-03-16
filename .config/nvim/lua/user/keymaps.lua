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

function keymaps.dap.get_keys()
  return {
    { '<leader>dc', function() require('dap').continue() end },
    { '<leader>ds', function() require('dap').step_into() end },
    { '<leader>dn', function() require('dap').step_over() end },
    { '<leader>do', function() require('dap').step_out() end },
    { '<leader>db', function() require('dap').toggle_breakpoint() end },
  }
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

function keymaps.telescope.get_keys()
  return {
    { '<leader>ff', '<cmd>Telescope find_files<cr>' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
  }
end

keymaps.vim_tmux_navigator = {}

function keymaps.vim_tmux_navigator.get_keys()
  return {
    { '<c-h>',  '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<c-j>',  '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<c-k>',  '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<c-l>',  '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  }
end

function keymaps.setup()
  keymaps.general.setup()
end

return keymaps
