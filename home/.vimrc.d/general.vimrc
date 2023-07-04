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
set background=dark
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

set textwidth=120
set colorcolumn=+1

set nobackup
set nowritebackup
set noswapfile

set cmdheight=2 " message display

set updatetime=300 " for diagnostic messages
set timeoutlen=500

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

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

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

let g:tex_flavor = "latex" " prefer latex in tex files

"
" custom commands

" ctags
"command! MakeTags execute "!ctags -R . -o .tags"

"
" custom mappings

" space for fold toggling
nnoremap <leader><Space> za
vnoremap <leader><Space> za

" save to file
nnoremap <leader>w :w<CR>

"clear highlighted searches
nmap <silent> <leader>/ :nohlsearch<CR>

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

"
" settings and mappings for plugins

" vim-which-key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>

" vim-airline
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" nerdcommenter
let g:NERDCreateDefaultMappings = 1
"noremap <silent> <leader>cc <Plug>NERDCommenterComment
"noremap <silent> <leader>cu <Plug>NERDCommenterUncomment

" ale
let g:ale_lint_on_text_changed='never'
let g:ale_lint_delay=300
let g:ale_lint_on_save=1
let g:ale_lint_on_enter=0
let g:ale_virtualtext_cursor = 'current'
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
"let g:ale_disable_lsp = 1

" TODO
"nmap <silent> [c <Plug>(ale_previous_wrap)
"nmap <silent> ]c <Plug>(ale_next_wrap)

let g:ale_fixers = {
      \ 'tex' : ['remove_trailing_lines',  'trim_whitespace'],
      \ 'python' : ['black'],
      \ 'sh' : ['shfmt']
      \}

let b:ale_linters = {
      \ 'tex' : ['chktex'],
      \ 'cmake' : ['cmake-lint']
      \}

" coc.nvim
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-texlab',
      \ 'coc-json',
      \ 'coc-vimlsp',
      \ 'coc-go',
      \ 'coc-pyright',
      \ '@yaegassy/coc-pylsp',
      \ '@yaegassy/coc-ruff',
      \ 'coc-jedi',
      \ 'coc-yaml',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-metals',
      \ 'coc-sh'
      \ ]

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  "set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ga  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>gf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>gl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>C  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" fzf
if executable('fzf')
  nnoremap <silent> <leader>F :Files<cr>
  nnoremap <silent> <leader>b :Buffers<cr>
  nnoremap <silent> <leader>h :History<cr>
end

" vim-markdown
let g:vim_markdown_initial_foldlevel=1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2

" SimpylFold
let g:SimpylFold_docstring_preview=1

" tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>
nnoremap <silent> <F10> :TagbarTogglePause<CR>

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'scala',
    \ 'sro'       : '.',
    \ 'kinds'     : [
      \ 'p:packages',
      \ 'T:types:1',
      \ 't:traits',
      \ 'o:objects',
      \ 'O:case objects',
      \ 'c:classes',
      \ 'C:case classes',
      \ 'm:methods',
      \ 'V:values:1',
      \ 'v:variables:1'
    \ ]
\ }


"let g:UltiSnipsExpandTrigger='<c-j>'
"let g:UltiSnipsJumpForwardTrigger='<c-j>'
"let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" vim-dispatch
nnoremap <F5> :Dispatch<CR>

" vim-session
let g:session_command_aliases=1
let g:session_autosave='no'
let g:session_autoload = 'no'
let g:session_autosave_periodic=10
let g:session_autosave_silent=1

set sessionoptions+=tabpages " save tabs
set sessionoptions-=buffers " do not save hidden and unloaded buffers

nnoremap <silent> <leader>O :SessionOpen<CR>

" vim-tmux-navigator
let g:tmux_navigator_save_on_switch = 1

" vim-windowswap
let g:windowswap_map_keys = 0 "prevent default bindings

nnoremap <silent> <leader>yy :call WindowSwap#EasyWindowSwap()<CR>
"nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
"nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<C>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
"nmap <silent> <leader>a :TestSuite<CR>
"nmap <silent> <leader>l :TestLast<CR>
"nmap <silent> <leader>g :TestVisit<CR>

let test#strategy = "dispatch"

" autocommands
if has("autocmd")
  " remember last edit location
  au! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  augroup restore_cursor
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
  augroup END

  " follow python pep8 standards
  au! BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=88 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix |
      \ let python_highlight_all=1

  " llvm
  au! BufRead,BufNewFile *.ll set filetype=llvm
  au! BufRead,BufNewFile *.td set filetype=tablegen

  " flex file should use lex file syntax
  au! BufNewFile,BufRead *.flex set filetype=lex

  " qml
  au! BufNewFile,BufRead *.qml set filetype=javascript

  " markdown
  au! BufNewFile,BufRead *.md set filetype=markdown
  au! FileType markdown set textwidth=120

  " TeX and friends
  au! BufNewFile,BufRead *.tex set filetype=tex
  au! FileType tex
        \ set textwidth=0 |
        \ set fo+=n |
        \ set wrap linebreak |
        \ let &showbreak="\u21aa "

  " on git commit messages set column width to 72
  au! FileType gitcommit setlocal spell textwidth=72

  " strip trailing whitespace for the below file suffixes
  au! BufWritePre *.c,*.cpp,*.cc,*.h,*.hh,*.hpp,*.java,*.cmake :%s/\s\+$//e

  " vim-codefmt
  augroup autoformat_settings
    autocmd!
    autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    autocmd FileType gn AutoFormatBuffer gn
    autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python AutoFormatBuffer black
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType rust AutoFormatBuffer rustfmt
    autocmd FileType vue AutoFormatBuffer prettier
    autocmd FileType swift AutoFormatBuffer swift-format
  augroup END
endif


" load local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
