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

" message display
set cmdheight=2

" for diagnostic messages
set updatetime=300

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

function! Synctex()
  " remove 'silent' for debugging
  execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
endfunction
map <C-enter> :call Synctex()<cr>

" settings and mappings for plugins

" vim-which-key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>

if executable('rg')
  set grepprg=rg\ --vimgrep
endif

if &runtimepath =~ 'vim-airline'
  let g:airline_theme='base16_gruvbox_dark_hard'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#ale#enabled = 1
endif


if &runtimepath =~ 'ale'
  let g:ale_lint_on_text_save='never'
  let g:ale_lint_delay=300
  let g:ale_lint_on_save=1
  let g:ale_lint_on_enter=0
endif

let g:ale_fixers = {
      \ 'tex' : ['remove_trailing_lines',  'trim_whitespace'],
      \ 'python' : ['black'],
      \ 'sh' : ['shfmt']
      \}

let b:ale_linters = {
      \ 'tex' : ['chktex'],
      \ 'cmake' : ['cmake-lint']
      \}

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
" coc.nvim config

let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-texlab',
      \ 'coc-json',
      \ 'coc-vimlsp',
      \ 'coc-go',
      \ 'coc-pyright',
      \ 'coc-jedi',
      \ 'coc-yaml',
      \ 'coc-clangd',
      \ 'coc-cmake',
      \ 'coc-metals',
      \ 'coc-sh'
      \ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
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
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
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

" prefer latex in tex files
let g:tex_flavor = "latex"

if has("autocmd")
  " remember last edit location
  "au! BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

  augroup resCur
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

  " disable highlighting for coursera compilers COOL files
  au! BufNewFile,BufRead *.cl set filetype=

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

  " clang-format plugin
  au! FileType c,cpp nnoremap <buffer> <leader>f :ClangFormat<CR>

  " auto-format plugin
  au! BufNewFile,BufRead * if &filetype != "c" && &filetype != "cpp"
        \ | nnoremap <buffer> <leader>f :Autoformat<CR>

  " vim-lsp plugin
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

  " vim-lsp-cquery
  autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fv :LspCqueryDerived<CR>
  autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fc :LspCqueryCallers<CR>
  autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fb :LspCqueryBase<CR>
  autocmd FileType c,cc,cpp,cxx,h,hpp nnoremap <leader>fi :LspCqueryVars<CR>

  augroup autoformat_settings
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


if &runtimepath =~ 'ctrlp.vim'
  " use current file dir and current repo dir as cwd
  let g:ctrlp_working_path_mode = 'ra'

  " some default ignores
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
        \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
        \}

  if executable('ag')
    " ag is fast enough that ctrlp doesn't need to cache
    let g:ctrlp_use_caching = 0

    " use ag in ctrlp for listing files lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  endif

  nnoremap <leader>p :CtrlP<CR>
  "nmap <leader>b :CtrlPBuffer<CR>
  nmap <leader>pm :CtrlPMixed<CR>
  nmap <leader>pr :CtrlPMRU<CR>
endif


let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


if executable('fzf')
  "nnoremap <silent> <C-t> :FZF -m<cr>
  "nnoremap <silent> <C-p> :FZF -m<cr>

  nnoremap <silent> <leader>F :Files<cr>
  nnoremap <silent> <leader>b :Buffers<cr>
  nnoremap <silent> <leader>h :History<cr>
end

let g:vim_markdown_initial_foldlevel=1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2


if exists(':NERDTreeToggle')
  map <C-n> :NERDTreeToggle<CR>
endif


if &runtimepath =~ 'SimpylFold'
  let g:SimpylFold_docstring_preview=1
endif


if &runtimepath =~ 'tagbar'
  nnoremap <silent> <F9> :TagbarToggle<CR>
  nnoremap <silent> <F10> :TagbarTogglePause<CR>
endif

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


if &runtimepath !~ 'asyncomplete-ultisnips'
  let g:UltiSnipsExpandTrigger='<c-j>'
  let g:UltiSnipsJumpForwardTrigger='<c-j>'
  let g:UltiSnipsJumpBackwardTrigger='<c-k>'
endif

let g:autoformat_autoindent = 0
let g:formatters_python = ['black']

"if &runtimepath =~ 'vim-clang-format'
  "let g:clang_format#command = 'clang-format.sh'
  "let g:clang_format#code_style = "llvm"
  "let g:clang_format#auto_format = 0
  "let g:clang_format#detect_style_file = 1
"endif


nnoremap <F5> :Dispatch<CR>

let g:instant_markdown_autostart = 0
let g:instant_markdown_slow = 1

imap <c-a> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

nn <silent> <leader>gd :LspDefinition<cr>
nn <silent> <leader>gr :LspReferences<cr>
nn <silent> <leader>gt :LspHover<cr>
"nn <silent> <M-=> :LspDocumentFormat<cr>
nn <leader>rr :LspRename<cr>

let g:lsp_signs_enabled = 1 " enable signs

let g:lsp_signs_error = {'text': 'E'}
let g:lsp_signs_warning = {'text': 'W'}
let g:lsp_signs_hint = {'text': 'I'}

" enable echo under cursor when in normal mode
let g:lsp_diagnostics_echo_cursor = 0

let g:lsp_preview_keep_focus = 0

" debugging flags
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

if executable('cquery')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
endif

if executable('pyls')
  " pip install python-language-server
  au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ 'workspace_config': {'pyls': {'plugins': {'pydocstyle': {'enabled': v:true}}}}
        \ })
endif

if executable('bash-language-server')
  " npm i -g bash-language-server
  au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'whitelist': ['sh'],
        \ })
endif


if &runtimepath =~ 'vim-session'
  let g:session_command_aliases=1
  let g:session_autosave='no'
  let g:session_autoload = 'no'
  let g:session_autosave_periodic=10
  let g:session_autosave_silent=1

  set sessionoptions+=tabpages " save tabs
  set sessionoptions-=buffers " do not save hidden and unloaded buffers
endif


let g:tmux_navigator_save_on_switch = 1

if &runtimepath =~ 'vim-windowswap'
  let g:windowswap_map_keys = 0 "prevent default bindings

  "nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
  "nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<C>

  nnoremap <silent> <leader>yy :call WindowSwap#EasyWindowSwap()<CR>
endif

" load local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

