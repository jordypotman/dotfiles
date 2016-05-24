" Jordy Potman's .vimrc.

" Auto reload .vimrc.
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Leader
let mapleader = "\<Space>"

" Automatically install vim-plug and all plugins.
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

  Plug 'altercation/vim-colors-solarized'
  Plug 'bling/vim-airline'
  Plug 'christoomey/vim-tmux-navigator'
  if executable('lldb')
    Plug 'gilligan/vim-lldb'
  endif
  " Vim text objects for comments.
  Plug 'glts/vim-textobj-comment'
  Plug 'ctrlpvim/ctrlp.vim'
  " File system explorer.
  Plug 'jeetsukumaran/vim-filebeagle'
  " Library plugin to define your own text objects.
  " Dependency for vim-textobj-comment.
  Plug 'kana/vim-textobj-user'
  " Automatic management of tag files.
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'rking/ag.vim'
  " Rust file detection and syntax highlighting.
  Plug 'rust-lang/rust.vim'
  Plug 'scrooloose/nerdtree'
  " Run files through external syntax checkers and display any resulting
  " errors.
  Plug 'scrooloose/syntastic'
  " Instant Markdown preview.
  Plug 'suan/vim-instant-markdown'
  " Vim sugar for UNIX shell commands such as rm, mv, chmod, mkdir, find, etc.
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  " Automatically adjust 'shiftwidth' and 'expandtab'.
  Plug 'tpope/vim-sleuth'
  " Easily add, change or delete surrounding parentheses, brackets, quotes, etc.
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  if v:version > 703 || v:version == 703 && has('patch598')
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
  endif
  " Settings for LLVM assembly *.ll and tablegen *.td files.
  if isdirectory(expand('~/toolbox/share/llvm/vim'))
    Plug '~/toolbox/share/llvm/vim'
  endif

  call plug#end()
endif

" Enable file type detection including loading the plugin and indent files for
" specfic types.
filetype plugin indent on

" Make the % command jump to matching keyword such as if/else/endif.
runtime macros/matchit.vim

" Enable hidden buffers.
set hidden

" Automatically read files again that have been changed outside of Vim.
set autoread

" Automatically write files before commands such as :make.
set autowrite

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
set undodir=~/.vim/undo//
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

" Enable line numbering.
set number

" Highlight column 81.
set colorcolumn=81

" Turn wrapping of lines longer than the width of the window off.
set nowrap

" Use colors which look good on dark backgrounds.
set background=dark

" Try to set the colorscheme to solarized but do not report an error if it is
" not available.
silent! colorscheme solarized

" Enable the use of the mouse in all four modes.
set mouse=a

" Enable resizing split panes by dragging in tmux.
" See: http://superuser.com/questions/549930/cant-resize-vim-splits-inside-tmux
if &term =~ '^screen'
  set ttymouse=xterm2
endif

" Open new split panes to the right of or below the current pane.
set splitright
set splitbelow

" Let C-n and C-p filter command history.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Let S split lines (the opposite of J, which joins lines).
" The normal use of S is covered by cc, so don't worry about shadowing it.
map S i<CR><Esc>

" NERDTree settings
let NERDTreeHijackNetrw = 0

" Syntastic settings
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-instant-markdown settings
let g:instant_markdown_autostart = 0

" vim-lldb mappings
let g:lldb_map_Lbreakpoint = "<leader>b"
let g:lldb_map_Lcontinue = "<leader>c"
let g:lldb_map_Lstep = "<leader>s"
let g:lldb_map_Lnext = "<leader>n"

" YouCompleteMe fallback configuration file.
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']

augroup ft_c_cpp
  autocmd!
  autocmd FileType c,cpp set cindent
  autocmd FileType c,cpp set comments^=:///
  autocmd FileType c,cpp nnoremap <buffer> <leader>g :YcmCompleter GoTo<CR>
  if filereadable(expand('~/toolbox/share/clang/clang-format.py'))
    autocmd FileType c,cpp map <buffer> <leader>f :pyf ~/toolbox/share/clang/clang-format.py<CR>
  endif
augroup END

augroup ft_llvm_make
  autocmd!
  " Categorize LLVM Makefiles with names such as Makefile.rules or
  " TEST.nightly.Makefile, as Makefiles.
  autocmd BufRead,BufNewFile *Makefile* set filetype=make
augroup END

augroup ft_markdown
  autocmd!
  " Set filetype of *.md files to Markdown instead of Modula-2.
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
