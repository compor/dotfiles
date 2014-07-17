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
Plugin 'kshenoy/vim-signature'

call vundle#end()

filetype plugin indent on

" change the mapleader from \ to ,
let mapleader=","

syntax on
set t_Co=256
color desert

set hidden
set backspace=indent,eol,start
set showmatch
set number
set numberwidth=5
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

set textwidth=80
set colorcolumn=+1

set nobackup
set noswapfile

set foldmethod=syntax
set foldcolumn=1
set foldlevel=4
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

set pastetoggle=<leader>p

if has('autocmd')
    autocmd filetype python set expandtab
endif

" disable highlighting for coursera compilers COOL files
au BufNewFile,BufRead *.cl set filetype=

" flex file should use lex file syntax
au BufNewFile,BufRead *.flex set filetype=lex

" markdown
au BufNewFile,BufRead *.md set filetype=markdown

" on git commit messages set column width to 72
au FileType gitcommit set textwidth=72

" strip trailing whitespace for the below file suffixes
au BufWritePre *.c,*.cpp,*.cc,*.h,*.hh,*.hpp,*.java :%s/\s\+$//e

" auto save and load views
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview

"save changes to open file even if not opened as root
cnoremap sudow w !sudo tee % >/dev/null

"clear highlighted searches by pressing / again
nmap <silent> <leader>/ :nohlsearch<CR>


"mappings for plugins
"NERDTree
map <C-n> :NERDTreeToggle<CR>

" local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


