local commands = {}

function commands.setup()
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
