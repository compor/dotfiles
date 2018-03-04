
let g:ycm_confirm_extra_conf=0
let g:ycm_complete_in_comments=1
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_key_list_select_completion=[ '<TAB>', '<Enter>' ]
let g:ycm_key_list_previous_completion=[ '<S-TAB>', '<S-Enter>' ]
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_always_populate_location_list=1
map <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>gt :YcmCompleter GetType<CR>

