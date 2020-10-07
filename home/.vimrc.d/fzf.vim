
if executable('fzf')
  "nnoremap <silent> <C-t> :FZF -m<cr>
  "nnoremap <silent> <C-p> :FZF -m<cr>

  nnoremap <silent> <leader>F :Files<cr>
  nnoremap <silent> <leader>b :Buffers<cr>
  nnoremap <silent> <leader>h :History<cr>
end
