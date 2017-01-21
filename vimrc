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

  " Precision colorscheme.
  Plug 'altercation/vim-colors-solarized'

  " Automatically adjust 'shiftwidth' and 'expandtab'.
  Plug 'tpope/vim-sleuth'

  " Automatic management of tag files.
  Plug 'ludovicchabant/vim-gutentags'

  " Fast, as-you-type, fuzzy-search code completion engine.
  if v:version > 703 || v:version == 703 && has('patch598')
    Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
  endif

  " Seamless navigation between tmux panes and vim splits.
  Plug 'christoomey/vim-tmux-navigator'

  " Filesystem tree explorer.
  Plug 'scrooloose/nerdtree'

  " Pairs of handy bracket mappings.
  Plug 'tpope/vim-unimpaired'

  " Fuzzy file, buffer, most recently used, tag, etc finder.
  Plug 'ctrlpvim/ctrlp.vim'

  " Git wrapper.
  Plug 'tpope/vim-fugitive'

  " File system explorer.
  Plug 'jeetsukumaran/vim-filebeagle'

  " Sidebar that displays tags of the current file, ordered by scope.
  Plug 'majutsushi/tagbar'

  " Asynchronous build and test dispatcher.
  Plug 'tpope/vim-dispatch'

  " Run files through external syntax checkers and display any resulting
  " errors.
  Plug 'scrooloose/syntastic'

  " Instant Markdown preview.
  Plug 'suan/vim-instant-markdown'

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

  " Syntax and makeprg support for PlantUML
  Plug 'aklt/plantuml-syntax'

  " Personal Wiki for Vim.
  Plug 'vimwiki/vimwiki'

  " Settings for LLVM assembly *.ll and tablegen *.td files.
  if isdirectory(expand('~/toolbox/share/llvm/vim'))
    Plug '~/toolbox/share/llvm/vim'
  endif

  " Rust file detection, syntax highlighting, formatting, Syntastic
  " integration, and more.
  Plug 'rust-lang/rust.vim'

  " Front for ag, a.k.a. the_silver_searcher.
  Plug 'rking/ag.vim'

  " LLDB debugger integration.
  if executable('lldb')
    Plug 'gilligan/vim-lldb'
  endif

  call plug#end()
endif

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

" Complete till longest common string, showing all matches in wildmenu on
" first press of <Tab>, complete the next full match on second press of <Tab>.
" See: http://stackoverflow.com/questions/526858
set wildmode=longest:full,full

" Let C-n and C-p filter command history.
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Let S split lines (the opposite of J, which joins lines).
" The normal use of S is covered by cc, so don't worry about shadowing it.
map S i<CR><Esc>

" Airline settings
let g:airline_left_sep=''
let g:airline_right_sep=''

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

" Automatically reload .vimrc.
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

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
  autocmd BufNewFile,BufReadPost *Makefile* set filetype=make
augroup END

augroup ft_markdown
  autocmd!
  " Set filetype of *.md files to Markdown instead of Modula-2.
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
