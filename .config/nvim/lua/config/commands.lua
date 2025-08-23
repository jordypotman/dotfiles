local commands = {}

function commands.setup()

  vim.api.nvim_create_user_command('DiagnosticsToggle',
    function()
      vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, {})

  vim.api.nvim_create_user_command('DiagnosticsUnderlineToggle',
    function()
      vim.diagnostic.config({ underline = not vim.diagnostic.config().underline });
    end, {})

  vim.api.nvim_create_user_command('DiagnosticsVirtualTextToggle',
    function()
      vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text });
    end, {})

  local function get_min_severity(opts)
    return { severity = { min = opts.fargs[1] } }
  end
  local function complete_diagnostic_severity()
    return { unpack(vim.diagnostic.severity) }
  end

  vim.api.nvim_create_user_command('DiagnosticsUnderlineMinSeverity',
    function(opts)
      vim.diagnostic.config({ underline = get_min_severity(opts) })
    end,
    { nargs = 1, complete = complete_diagnostic_severity })

  vim.api.nvim_create_user_command('DiagnosticsVirtualTextMinSeverity',
    function(opts)
      vim.diagnostic.config({ virtual_text = get_min_severity(opts) })
    end,
    { nargs = 1, complete = complete_diagnostic_severity })

  -- Make focussed window more obvious by starting the colorcolumn from
  -- column 1 and disabling the cursorline in unfocussed windows.
  -- Based on: https://github.com/wincent/wincent/blob/2aa44544fe9e8fc466fea42391e66fff3583054c/roles/dotfiles/files/.vim/plugin/autocmds.vim
  -- and: https://github.com/wincent/wincent/blob/2aa44544fe9e8fc466fea42391e66fff3583054c/roles/dotfiles/files/.vim/autoload/autocmds.vim
  vim.cmd([[
  let g:JPColorColumnBlacklist = ['diff', 'nerdtree', 'qf']

  function! s:JPShouldColorColumn() abort
    return index(g:JPColorColumnBlacklist, &filetype) == -1
  endfunction

  let g:JPCursorlineBlacklist = []

  function! s:JPShouldCursorLine() abort
    return index(g:JPCursorlineBlacklist, &filetype) == -1
  endfunction

  if has('autocmd')
    augroup jp_focus
      autocmd!

      if exists('+colorcolumn')
        autocmd BufEnter,FocusGained,VimEnter,WinEnter * if s:JPShouldColorColumn() | let &l:colorcolumn='+' . join(range(1, 255), ',+') | endif
        autocmd FocusLost,WinLeave * if s:JPShouldColorColumn() | let &l:colorcolumn=join(range(1, 255), ',') | endif
      endif
      autocmd InsertLeave,VimEnter,WinEnter * if s:JPShouldCursorLine() | setlocal cursorline | endif
      autocmd InsertEnter,WinLeave * if s:JPShouldCursorLine() | setlocal nocursorline | endif
    augroup END
  endif
  ]])
end

return commands
