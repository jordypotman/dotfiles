" Jordy Potman's .vimrc.

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Auto reload .vimrc.
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" Leader
let mapleader = "\<Space>"

" Automatically install vim-plug and all plugins.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Plugins.
call plug#begin('~/.vim/bundle')

Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gilligan/vim-lldb'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
" Easily add, change or delete surrounding parentheses, brackets, quotes, etc.
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }

call plug#end()

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

" A <tab> has a width of 2 blanks.
set softtabstop=2

" Use 2 blanks for each step of (auto)indent.
set shiftwidth=2

" Use the appropiate number of spaces to insert a <Tab>.
set expandtab

" Enable line numbering.
set number

" Highlight column 81.
set colorcolumn=81

" Turn wrapping of lines longer than the width of the window off.
set nowrap

" Use colors which look good on dark backgrounds.
set background=dark

" Set colorscheme to solarized.
colorscheme solarized

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

" vim-lldb mappings
let g:lldb_map_Lbreakpoint = "<leader>b"
let g:lldb_map_Lcontinue = "<leader>c"
let g:lldb_map_Lstep = "<leader>s"
let g:lldb_map_Lnext = "<leader>n"

" YouCompleteMe fallback configuration file.
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/.ycm_extra_conf.py']

" Change a few of the C indentation options from the defaults. See the help for
" cinoptions-values for details.
" :0  Place case labels 0 characters from the indent of the switch().
" l1  Align with a case label instead of the statment after it in the same line.
" g0  Place C++ scope declarations ("public:", "protected:" or "private:") 0
"     characters from the indent of the block they are in.
" (0  When in unclosed parentheses line up with the next non-whitespace
"     character after the unclosed parentheses.
" Ws  When in unclosed parentheses and the unclosed parentheses is the last
"     non-whitespace character in its line, indent the following line
"     'shiftwidth' characters relative to the outer context.
set cinoptions=:0,l1,g0,(0,Ws

augroup ft_c_cpp
  autocmd!
  autocmd FileType c,cpp set cindent
  autocmd FileType c,cpp nnoremap <buffer> <leader>g :YcmCompleter GoTo<CR>
  autocmd FileType c,cpp map <buffer> <leader>f :pyf ~/.vim/clang-format/clang-format.py<CR>
augroup END

augroup ft_llvm
  " Enable syntax highlighting for LLVM files. Requires
  " utils/vim/llvm.vim from the LLVM repository in  ~/.vim/syntax .
  au! BufRead,BufNewFile *.ll set filetype=llvm
augroup END

augroup ft_make
  autocmd!
  " LLVM Makefiles can have names such as Makefile.rules or
  " TEST.nightly.Makefile, so it's important to categorize them as such.
  autocmd BufRead,BufNewFile *Makefile* set filetype=make
  " In Makefiles, don't expand tabs to spaces, since we need the actual tabs.
  autocmd FileType make set noexpandtab
augroup END

augroup ft_tablegen
  " Enable syntax highlighting for LLVM tablegen files. Requires
  " utils/vim/tablegen.vim from the LLVM repository in ~/.vim/syntax/ .
  au! BufRead,BufNewFile *.td set filetype=tablegen
augroup END

augroup ft_markdown
  autocmd!
  " Set filetype of *.md files to Markdown instead of Modula-2.
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
