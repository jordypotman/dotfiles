" Jordy Potman's .vimrc.

" Set mapleader at top of .vimrc because it's value is used at the moment the
" mapping is defined. This way it also has effect on any leader mappings
" defined by plugins.
let mapleader = "\<Space>"

" Automatically install vim-plug Vim plugin manager and all plugins.
if empty(glob('~/.vim/autoload/plug.vim'))
  if executable('curl')
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
  if executable('wget')
    silent !mkdir -p ~/.vim/autoload
    silent !wget -O ~/.vim/autoload/plug.vim
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  endif
  if !empty(glob('~/.vim/autoload/plug.vim'))
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
endif

" Plugins.
if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/bundle')

  " A universal set of defaults that (hopefully) everyone can agree on.
  Plug 'tpope/vim-sensible'

  " Enable repeating supported plugin maps with '.'.
  Plug 'tpope/vim-repeat'

  " Lean & mean status/tabline that's light as air.
  Plug 'vim-airline/vim-airline'

  " A collection of themes for vim-airline.
  Plug 'vim-airline/vim-airline-themes'

  " Base16 for Vim.
  Plug 'chriskempson/base16-vim'

  " Automatically adjust 'shiftwidth' and 'expandtab'.
  Plug 'tpope/vim-sleuth'

  " Normalize async job control api for vim and neovim.
  " Dependency for vim-lsp
  Plug 'prabirshrestha/async.vim'

  " Async Language Server Protocol plugin for vim 8 and neovim.
  Plug 'prabirshrestha/vim-lsp'

  " Async completion in pure vim script for vim8 and neovim.
  Plug 'prabirshrestha/asyncomplete.vim'

  " Provides buffer autocomplete for asyncomplete.vim.
  Plug 'prabirshrestha/asyncomplete-buffer.vim'

  " LSP source for asyncomplete.vim.
  Plug 'prabirshrestha/asyncomplete-lsp.vim'

  " Seamless navigation between tmux panes and vim splits.
  Plug 'christoomey/vim-tmux-navigator'

  " Provides pseudo clipboard registers such as "& for the tmux paste buffer.
  Plug 'kana/vim-fakeclip'

  " Filesystem tree explorer.
  Plug 'scrooloose/nerdtree'

  " Pairs of handy bracket mappings.
  Plug 'tpope/vim-unimpaired'

  " Git wrapper.
  Plug 'tpope/vim-fugitive'

  " A vim-perforce integration plugin.
  Plug 'ngemily/vim-vp4'

  " Show a diff using Vim its sign column.
  Plug 'mhinz/vim-signify'

  " Directory viewer.
  Plug 'justinmk/vim-dirvish'

  " Asynchronous build and test dispatcher.
  Plug 'tpope/vim-dispatch'

  " Vim sugar for UNIX shell commands such as rm, mv, chmod, mkdir, find, etc.
  Plug 'tpope/vim-eunuch'

  " Easily add, change or delete surrounding parentheses, brackets, quotes, etc.
  Plug 'tpope/vim-surround'

  " Easily search for, substitute, and abbreviate multiple variants of a word.
  Plug 'tpope/vim-abolish'

  " Vim text objects for comments.
  Plug 'glts/vim-textobj-comment'

  " Library plugin to define your own text objects.
  " Dependency for vim-textobj-comment.
  Plug 'kana/vim-textobj-user'

  " Personal Wiki for Vim.
  Plug 'vimwiki/vimwiki'

  " Settings for LLVM assembly *.ll and tablegen *.td files.
  if isdirectory(expand('~/toolbox/share/llvm/vim'))
    Plug '~/toolbox/share/llvm/vim'
  endif

  " Syntax checking and highlighting for OpenCL files.
  Plug 'petRUShka/vim-opencl'

  Plug 'rickhowe/diffchar.vim'

  call plug#end()
endif

" Enable hidden buffers.
set hidden

" Enable line numbering.
set number

" Turn wrapping of lines longer than the width of the window off.
set nowrap

" Enable the use of the mouse in all four modes.
if has('mouse')
  set mouse=a
endif

" Enable resizing split panes by dragging in tmux.
" See: http://superuser.com/questions/549930/cant-resize-vim-splits-inside-tmux
if &term =~ '^screen'
  set ttymouse=xterm2
endif

" Open new split panes to the right of or below the current pane.
set splitright
set splitbelow

" Complete till longest common string, showing all matches in wildmenu on
" first press of <Tab>, complete the next full match on second press of <Tab>.
" See: http://stackoverflow.com/questions/526858
set wildmode=longest:full,full

" Folding.
if has('folding')
  " Faster than syntax.
  set foldmethod=indent

  " Start unfolded.
  set foldlevelstart=99
endif

" Ignore case in search patterns unless the pattern contains upper case
" characters.
set ignorecase
set smartcase

" Automatically read files again that have been changed outside of Vim.
set autoread

" Automatically write files before commands such as :make.
"set autowrite " Disabled because it also seems to write files when switching Vim windoes

" Set backup directory and create it if it does not exist yet.
set backupdir=~/.vim/backup//
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

" Set swap directory and create it if it does not exist yet.
set directory=~/.vim/swap//
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Set undo directory and create it if it does not exist yet.
if exists('&undodir')
  set undodir=~/.vim/undo//
  if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
  endif
endif

" Let C-n and C-p filter command history.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Let S split lines (the opposite of J, which joins lines).
" The normal use of S is covered by cc, so don't worry about shadowing it.
map S i<CR><Esc>

" Show the path of the current file. Useful when the file path in the status
" line gets truncated.
" From: https://github.com/wincent/wincent/blob/9d05971e45545929b25e4e8e129ff8366d973b4b/roles/dotfiles/files/.vim/plugin/mappings/leader.vim
nnoremap <Leader>p :echo expand('%')<CR>

" Make highlighted errors on current line readable when cursorline is enabled.
function! s:JPBase16Customize() abort
  " Colors: https://github.com/chriskempson/base16/blob/master/styling.md
  " Arguments: group, guifg, guibg, ctermfg, ctermbg, attr, guisp
  call Base16hi("Error", "", "", g:base16_cterm08, g:base16_cterm00, "reverse", "")
endfunction

augroup on_change_color_scheme
  autocmd!
  autocmd ColorScheme * call s:JPBase16Customize()
augroup END

" Set the color scheme based on the terminal color scheme.
" Based on: https://github.com/wincent/wincent/blob/f18eb9515df8b5e29c8d342ae726b07f9dd4096a/roles/dotfiles/files/.vim/after/plugin/color.vim
function! s:CheckColorScheme()
"  if has('termguicolors')
"    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"    set termguicolors
"  else
    let g:base16colorspace=256
"  endif

  let l:termcolors_config_file = expand('~/.termcolors')

  if filereadable(l:termcolors_config_file)
    let l:termcolors_config = readfile(l:termcolors_config_file)
    if empty(l:termcolors_config)
      echoerr 'Invalid termcolors config file ' . l:termcolors_config_file
      return
    endif
    let l:color_scheme = l:termcolors_config[0]
    execute 'colorscheme base16-' . l:color_scheme
  endif
endfunction

augroup check_color_scheme
  autocmd!
  autocmd FocusGained * call s:CheckColorScheme()
augroup END

call s:CheckColorScheme()

" Make focussed window more obvious by starting the colorcolumn from
" column 1 and disabling the cursorline in unfocussed windows.
" Based on: https://github.com/wincent/wincent/blob/2aa44544fe9e8fc466fea42391e66fff3583054c/roles/dotfiles/files/.vim/plugin/autocmds.vim
" and: https://github.com/wincent/wincent/blob/2aa44544fe9e8fc466fea42391e66fff3583054c/roles/dotfiles/files/.vim/autoload/autocmds.vim
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

" Airline settings
let g:airline_left_sep=''
let g:airline_right_sep=''

" NERDTree settings
let NERDTreeHijackNetrw = 0

" Vimwiki settings
let g:vimwiki_global_ext = 0

let private_wiki = {}
let private_wiki.path = '~/vimwiki/private'
let private_wiki.syntax = 'markdown'
let private_wiki.index = 'README'
let private_wiki.ext = '.md'

let public_wiki = {}
let public_wiki.path = '~/vimwiki/public'
let public_wiki.syntax = 'markdown'
let public_wiki.index = 'README'
let public_wiki.ext = '.md'

let personal_wiki = {}
let personal_wiki.path = '~/vimwiki/personal'
let personal_wiki.syntax = 'markdown'
let personal_wiki.index = 'README'
let personal_wiki.ext = '.md'

let recore_wiki = {}
let recore_wiki.path = '~/vimwiki/recore'
let recore_wiki.syntax = 'markdown'
let recore_wiki.index = 'README'
let recore_wiki.ext = '.md'

let g:vimwiki_list = []
if isdirectory(expand(private_wiki.path))
  let g:vimwiki_list += [private_wiki]
endif
if isdirectory(expand(public_wiki.path))
  let g:vimwiki_list += [public_wiki]
endif
if isdirectory(expand(personal_wiki.path))
  let g:vimwiki_list += [personal_wiki]
endif
if isdirectory(expand(recore_wiki.path))
  let g:vimwiki_list += [recore_wiki]
endif

" vim-lsp settings
let g:lsp_diagnostics_echo_cursor = 1

if executable('clangd')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd', '-background-index']},
    \ 'whitelist': ['c', 'cpp'],
    \ })
endif

function s:on_lsp_buffer_enabled() abort
  nmap <buffer> <leader>lgd <plug>(lsp-definition)
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that have a server
  " registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" asyncomplete.vim settings
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? !empty(v:completed_item) ? "\<C-y>" : "\<C-y>\<CR>" : "\<CR>"

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
\ 'name': 'buffer',
\ 'whitelist': ['*'],
\ 'blacklist': [],
\ 'completor': function('asyncomplete#sources#buffer#completor'),
\ 'config': {
\    'max_buffer_size': 5000000,
\  },
\ }))

" let g:lsp_log_verbose = 1
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')

" vim-signify settings
let g:signify_vcs_list = [ 'git', 'perforce' ]
let g:signify_realtime = 1

" vim-dirvish settings

" Sort directories before files, ignoring case.
let g:dirvish_mode = ':sort ir /^.*[^\/]$/'

augroup ft_dirvish
  autocmd!

  " Map + to create a new file.
  autocmd FileType dirvish nnoremap <buffer> + :edit %

  " Map gh to hide dotfiles.
  autocmd FileType dirvish nnoremap <buffer> <silent> gh :silent :keeppatterns g@\v/\.[^\/]+/?$@d<cr>
augroup END

" Automatically reload .vimrc.
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup ft_c_cpp
  autocmd!
  autocmd FileType c,cpp set cindent
  autocmd FileType c,cpp set comments^=:///
augroup END

augroup ft_llvm_make
  autocmd!
  " Categorize LLVM Makefiles with names such as Makefile.rules or
  " TEST.nightly.Makefile, as Makefiles.
  autocmd BufNewFile,BufReadPost *Makefile* set filetype=make
augroup END

augroup ft_markdown
  autocmd!
  " Set filetype of *.md files to Markdown instead of Modula-2.
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
