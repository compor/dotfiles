
if &runtimepath =~ 'vim-session'
  let g:session_command_aliases=1
  let g:session_autosave='no'
  let g:session_autoload = 'no'
  let g:session_autosave_periodic=10
  let g:session_autosave_silent=1

  set sessionoptions+=tabpages " save tabs
  set sessionoptions-=buffers " do not save hidden and unloaded buffers
endif

