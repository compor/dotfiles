
if exists(':ClangFormat')
  let g:clang_format#command = 'clang-format.sh'
  let g:clang_format#code_style = "llvm"
  let g:clang_format#auto_format = 0
  let g:clang_format#detect_style_file = 1
endif

