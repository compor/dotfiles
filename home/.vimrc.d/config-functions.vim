" vim functions

" toggle whitespace visibility based on solarized modes
function! ToggleVisibility()
  if g:solarized_visibility != 'high'
    let g:solarized_visibility = 'high'
  else
    let g:solarized_visibility = 'low'
  endif
  color solarized
endfunction

" toggle various visibility modes
nmap <leader>W :call ToggleVisibility()<CR>


" strip trailing whitespace function
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction


" add double quotes to line
function! DQuote()
  if !&binary && &filetype != 'diff'
    let line = getline('.')
    let dqline = join(["\"", "\""], line)
    call setline('.', dqline)
  endif
endfunction


" execute the current line in last active tmux pane
function! ExecInTmux()
  let line = getline('.')
  call system("tmux send-keys -t ! \"" . line . "\" . Enter")
endfunction

" map tmux execution of current line
nmap <leader>t :call ExecInTmux()<CR>

function! ToggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

nnoremap <silent> <leader>q :call ToggleQuickFix()<CR>
