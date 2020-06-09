" vimrc file

" use vim instead of vi settings
" must be set first as it changes other options as side effect
set nocompatible

" general config

set runtimepath=~/.vim
set runtimepath+=/usr/share/vim/vim82

scriptencoding utf-8
set encoding=utf-8

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" setup plugins
call plug#begin('~/.vim/plugged')

if filereadable(expand("~/.vimrc.plugins"))
  source ~/.vimrc.plugins
endif

call plug#end()

set noshowmode " do not show operation mode
set laststatus=2 " status line always on
set showtabline=2 " always display tabline

set path+=**

set wildmenu

"set clipboard=unnamed " clipboard behaviour

" change the mapleader
nnoremap <Space> <nop>
let mapleader="\<Space>"
let maplocalleader="\\"

inoremap <Space> <Space>

"set t_Co=256

"set background=dark
"let g:solarized_visibility="low"
"color solarized

"let g:gruvbox_italic=1
"let g:gruvbox_termcolors=16
color gruvbox

set hidden " allows hiding buffers although they might have unsaved mods
set backspace=indent,eol,start " delete over indent, end and start of line
set showmatch " jump momentarily (configurable) to the matching bracket
set relativenumber " precede each line with its relative line number
set numberwidth=5 " set width for each line number
set lazyredraw " do not redraw screen when executing macros

" specify new splits position
set splitbelow
set splitright

set pumheight=15 " set popup menu height

" indentation settings
set tabstop=2
set smarttab
set shiftwidth=2
set shiftround
set expandtab
set softtabstop=2
set autoindent
set copyindent

set nowrap " do not wrap lines

set textwidth=80
set colorcolumn=+1

set nobackup
set noswapfile

" folding settings
set foldmethod=syntax
set foldlevel=4
"set foldcolumn=1

" search settings
set smartcase " ignore the above if search pattern containes uppercase
set hlsearch " highlight matches of the search pattern
set incsearch " highlight matches while the search pattern is typed in
set nowrapscan " do not wrap search scans

set visualbell " no sounds
set noerrorbells

set history=1000
set undolevels=1000
set title
set wildignore=*.swp,*.bak,*.pyc,*.class

set pastetoggle=<F10>

" highlight trailing spaces
set list
set listchars=trail:·
set listchars+=tab:˫\

" reset expected tags files and add some more
set tags&
set tags+=.tags

set scrolloff=10 " show 10 lines above and below cursor

set cursorline

if &diff
  " disable annoying visual stuff when in diff mode
  syntax off
  set textwidth=0
  set colorcolumn=0
  highlight DiffAdd cterm=bold ctermfg=11 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=11 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=Green ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText cterm=bold ctermfg=11 ctermbg=88 gui=none guifg=bg guibg=Red
endif


" custom commands

" change buffer and delete previous one
command! Bd bp\|bd \#

" ctags
command! MakeTags execute "!ctags -R . -o .tags"


" custom mappings

" space for fold toggling
nnoremap <leader><Space> za
vnoremap <leader><Space> za

" save open file even if not root
cnoremap sudow w !sudo tee % >/dev/null

" save to file
nnoremap <leader>w :w<CR>

"clear highlighted searches
nmap <silent> <leader>/ :nohlsearch<CR>


" buffer movements mappings

" close current buffer and move to previous
nmap <leader>bq :bp <BAR> bd #<CR>

" settings and mappings for plugins

" stolen from http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" load extra config
if filereadable($HOME . "/.vimrc.extra")
  source ~/.vimrc.extra
endif

" load functions
if filereadable(expand("~/.vimrc.d/config-functions.vim"))
  source ~/.vimrc.d/config-functions.vim
endif

" load extra configs
let config_dir = $HOME . '/.vimrc.d'

for file_path in split(globpath(config_dir, '*.vim'), '\n')
  exe 'source' file_path
endfor

" load local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

