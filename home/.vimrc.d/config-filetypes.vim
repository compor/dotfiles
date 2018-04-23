
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
      \ set textwidth=79 |
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
  au! FileType tex set textwidth=120
  
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
endif

