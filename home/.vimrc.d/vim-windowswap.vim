
if &runtimepath =~ 'gundo'
  let g:windowswap_map_keys = 0 "prevent default bindings

  "nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
  "nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<C>

  nnoremap <silent> <leader>yy :call WindowSwap#EasyWindowSwap()<CR>
endif

