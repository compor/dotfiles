" vimrc file used with vim 7.4 and various plugins

set nocompatible

set runtimepath=~/.vim
set runtimepath+=/usr/share/vim/vim74
set runtimepath+=~/.vim/bundle/Vundle.vim

scriptencoding utf-8
set encoding=utf-8

" setup plugins
call vundle#begin()

if filereadable(expand("~/.vimrc.plugins"))
    source ~/.vimrc.plugins
endif

call vundle#end()

filetype plugin indent on

" change the mapleader from \ to ,
let mapleader=","

" vim/markdown plugin options
let g:vim_markdown_initial_foldlevel=1

syntax on
set t_Co=256
set background=dark
"let g:solarized_visibility="high"
"let g:solarized_visibility="medium"
let g:solarized_visibility="low"
color solarized
"color desert

" changed default terminal search highlighting
" to something more visible
"highlight Search ctermfg=20 ctermbg=120 gui=none guifg=bg guibg=Red
"highlight IncSearch ctermfg=20 ctermbg=120 gui=none guifg=bg guibg=Red

" allows hiding buffers although they might contain unsaved modifications
set hidden

" delete over indent, end and start of line
set backspace=indent,eol,start

" jump momentarily (configurable) to the matching bracket
set showmatch

" precede each line with its line number
set number

" set width for each line number
set numberwidth=5

" do not redraw screen when executing macros
set lazyredraw

set tabstop=4
set smarttab
set shiftwidth=4
set shiftround
set expandtab
set softtabstop=4

set autoindent
set copyindent

" do not wrap search scans
set nowrapscan

set nowrap

set textwidth=80
set colorcolumn=+1

set nobackup
set noswapfile

set foldmethod=syntax
set foldcolumn=1
set foldlevel=4

" ignore letter case in searches
set ignorecase

" ignore the above if search pattern containes uppercase
set smartcase

" highlight matches of the search pattern
set hlsearch

" highlight matches while the search pattern is typed in
set incsearch

" stolen from http://robots.thoughtbot.com/faster-grepping-in-vim
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " disabled because ctrlp is not used for now
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0
endif

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
set listchars+=tab:˫\ 

" show cursor line and col number plus relative position in file
" statusline takes precedence
set ruler

" set status line options
" status line always on
set laststatus=2

set statusline=             "clear status line
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}]     "file format
set statusline+=%h          "help file flag
set statusline+=%m          "modified flag
set statusline+=%r          "read only flag
set statusline+=%y          "filetype
set statusline+=[%<%F%*]    "full path
set statusline+=%=          "left/right separator
set statusline+=%c,         "cursor column
set statusline+=%l/%L       "cursor line/total lines
set statusline+=\ [0x%04B\] "character under cursor
set statusline+=\ %P        "percent through file

" reset expected tags files and add some more
set tags&
set tags+=.tags

" show 10 lines above and below cursor
set scrolloff=10

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" remove trailing whitespace from bestofvim.com
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

if has('autocmd')
    autocmd filetype python set expandtab
endif

" disable highlighting for coursera compilers COOL files
au BufNewFile,BufRead *.cl set filetype=

" flex file should use lex file syntax
au BufNewFile,BufRead *.flex set filetype=lex

" qml
au BufNewFile,BufRead *.qml set filetype=javascript

" markdown
au BufNewFile,BufRead *.md set filetype=markdown

" TeX and friends
au BufNewFile,BufRead *.tex set filetype=tex

" on git commit messages set column width to 72
au FileType gitcommit setlocal spell textwidth=72

au FileType markdown set textwidth=120
au FileType tex set textwidth=120

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


" toggle whitespace visibility based on solarized modes
function! s:ToggleVisibility()
    if g:solarized_visibility != 'high'
        let g:solarized_visibility = 'high'
    else
        let g:solarized_visibility = 'low'
    endif
    color solarized
endfunction

map <leader>w :call <SID>ToggleVisibility()<CR>


" strip trailing whitespace for the below file suffixes
au BufWritePre *.c,*.cpp,*.cc,*.h,*.hh,*.hpp,*.java :%s/\s\+$//e

" auto save and load views
"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview

" try out ctags manually for now
nnoremap <F6> :!ctags -R<CR>

" save changes to open file even if not opened as root
cnoremap sudow w !sudo tee % >/dev/null

"clear highlighted searches by pressing / again
nmap <silent> <leader>/ :nohlsearch<CR>


" mappings for plugins
" NERDTree
map <C-n> :NERDTreeToggle<CR>

" tagbar
nnoremap <silent> <Leader>b :TagbarToggle<CR>

" space for fold toggling
nnoremap <Space> za
vnoremap <Space> za

" local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


