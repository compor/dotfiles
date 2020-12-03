
if &runtimepath =~ 'ale'
  let g:ale_lint_on_text_save='never'
  let g:ale_lint_delay=300
  let g:ale_lint_on_save=1
  let g:ale_lint_on_enter=0
endif

let g:ale_fixers = {
      \ 'tex' : ['remove_trailing_lines',  'trim_whitespace'],
      \ 'sh' : ['shfmt']
      \}

let b:ale_linters = {
      \ 'tex' : ['chktex'],
      \ 'cmake' : ['cmake-lint', 'cmakelint']
      \}

