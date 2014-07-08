" vimrc file used with vim 7.4 and various plugins

set nocompatible

set runtimepath=~/.vim
set runtimepath+=/usr/share/vim/vim74
set runtimepath+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

call vundle#end()

filetype plugin indent on

syntax on
set t_Co=256
color desert

set hidden
set backspace=indent,eol,start
set showmatch
set number
set tabstop=4
set smarttab
set shiftwidth=4
set shiftround
set expandtab
set softtabstop=4
set autoindent
set copyindent
set ruler
set nowrap

set ignorecase
set smartcase
set hlsearch
set incsearch

set visualbell
set noerrorbells

set history=1000
set undolevels=1000
set title
set wildignore=*.swp,*.bak,*.pyc,*.class

set pastetoggle=<F2>

if has('autocmd')
    autocmd filetype python set expandtab
endif


au BufNewFile,BufRead *.cl set filetype=
au BufNewFile,BufRead *.flex set filetype=lex

au BufWritePre *.c,*.cpp,*.cc,*.h,*.hh,*.hpp,*.java :%s/\s\+$//e

"save changes to open file even if not opened as root
cnoremap sudow w !sudo tee % >/dev/null

"clear highlighted searches by pressing / again
nmap <silent> ,/ :nohlsearch<CR>


"mappings for plugins
"NERDTree
map <C-n> :NERDTreeToggle<CR>


