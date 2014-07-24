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

" changed default terminal search highlighting
" to something more visible
highlight Search ctermfg=20 ctermbg=120 gui=none guifg=bg guibg=Red
highlight IncSearch ctermfg=20 ctermbg=120 gui=none guifg=bg guibg=Red
highlight DiffAdd cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

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

" highlight trailing spaces
set list
set listchars=trail:·
" set status line options

set laststatus=2

set statusline=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

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
au FileType gitcommit setlocal spell textwidth=72

au FileType markdown set textwidth=120

if &diff
    set textwidth=0
    set colorcolumn=0
endif

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


