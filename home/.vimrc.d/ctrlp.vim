
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
  nmap <leader>b :CtrlPBuffer<CR>
  nmap <leader>pm :CtrlPMixed<CR>
  nmap <leader>pr :CtrlPMRU<CR>
endif

