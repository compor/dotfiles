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

" show operation mode
set showmode

filetype plugin indent on

" clipboard behaviour
set clipboard=unnamed

" change the mapleader
nnoremap <Space> <nop>
let mapleader="\<Space>"
let maplocalleader="\\"

inoremap <Space> <Space>

syntax on
set t_Co=256
set background=dark
let g:solarized_visibility="low"
color solarized

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

" specify new splits position
set splitbelow
set splitright

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

" ignore the above if search pattern containes uppercase
set smartcase

" highlight matches of the search pattern
set hlsearch

" highlight matches while the search pattern is typed in
set incsearch

" stolen from http://robots.thoughtbot.com/faster-grepping-in-vim
" The Silver Searcher
if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  if exists(':CtrlP')
    " ag is fast enough that ctrlp doesn't need to cache
    let g:ctrlp_use_caching = 0

    " use ag in ctrlp for listing files lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  endif
endif

if exists(':CtrlP')
  " use current file dir and current repo dir as cwd
  let g:ctrlp_working_path_mode = 'ra'

  " some default ignores
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
        \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
        \}
endif

set visualbell
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

" status line always on
set laststatus=2 

" always display the tabline, even if there is only one tab
"set showtabline=2

" hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode

" set status line options
set ruler
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

" remove trailing whitespace from bestofvim.com
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" space for fold toggling
nnoremap <leader><Space> za
vnoremap <leader><Space> za

if has("autocmd")
  " remember last edit location
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  " follow python pep8 standards
  au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix |
      \ let python_highlight_all=1
      
  " disable highlighting for coursera compilers COOL files
  au BufNewFile,BufRead *.cl set filetype=

  " flex file should use lex file syntax
  au BufNewFile,BufRead *.flex set filetype=lex

  " qml
  au BufNewFile,BufRead *.qml set filetype=javascript

  " markdown
  au BufNewFile,BufRead *.md set filetype=markdown
  au FileType markdown set textwidth=120

  " TeX and friends
  au BufNewFile,BufRead *.tex set filetype=tex
  au FileType tex set textwidth=120
  
  " on git commit messages set column width to 72
  au FileType gitcommit setlocal spell textwidth=72
 
  " strip trailing whitespace for the below file suffixes
  au BufWritePre *.c,*.cpp,*.cc,*.h,*.hh,*.hpp,*.java,*.cmake :%s/\s\+$//e

endif


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

nmap <leader>W :call <SID>ToggleVisibility()<CR>


function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

" try out ctags manually for now
nnoremap <F6> :!ctags -R<CR>

" save changes to open file even if not opened as root
cnoremap sudow w !sudo tee % >/dev/null

" save to file
nnoremap <leader>w :w<CR>
"clear highlighted searches by pressing / again
nmap <silent> <leader>/ :nohlsearch<CR>
" buffer movements mappings

" move to next buffer
nmap <leader>l :bnext<CR>

" move to previous buffer
nmap <leader>h :bprevious<CR>

" show all open buffers
"nmap <leader>b :ls<CR>

" close current buffer and move to previous one
nmap <leader>bq :bp <BAR> bd #<CR>


" mappings for plugins

" vim/markdown plugin options
let g:vim_markdown_initial_foldlevel=1

" ultisnips plugin options
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" ycm
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_key_list_select_completion=[ '<TAB>', '<Enter>' ]
let g:ycm_key_list_previous_completion=[ '<S-TAB>', '<S-Enter>' ]
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" nerdtree
map <C-n> :NERDTreeToggle<CR>
"nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>n :NERDTreeTabsToggle<CR>

" ctrlp
nnoremap <leader>p :CtrlP<CR>

nmap <leader>b :CtrlPBuffer<CR>
nmap <leader>pm :CtrlPMixed<CR>
nmap <leader>pr :CtrlPMRU<CR>

" tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> <F10> :TagbarTogglePause<CR>

" vim-session
let g:session_sutosave='no'
let g:session_autoload='no'

" hardtime
nnoremap <leader>h :HardTimeToggle<CR>
let g:hardtime_default_on = 1
let g:hardtime_ignore_buffer_patterns = [ "NERD.*" ]
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 3
let g:list_of_visual_keys = []
let g:list_of_disabled_keys = [ "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" ]

" vim-tmux-navigator
let g:tmux_navigator_save_on_switch = 1

" vim-clang-format
let g:clang_format#command = 'clang-format.sh'
let g:clang_format#code_style = "llvm"
let g:clang_format#auto_format = 0
let g:clang_format#detect_style_file = 1

nnoremap <leader>f :ClangFormat<CR>

" simplyfold
let g:SimpylFold_docstring_preview=1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" eclim
let g:EclimCompletionMethod = 'omnifunc'

" local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif


