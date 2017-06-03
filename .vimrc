

set bg=dark
" syntax off
" set foldmethod=manual
set foldlevel=999999


set showcmd             " display incomplete commands
set incsearch           " do incremental searching

set noautoindent " let me hack damnit

set backup " xemacs like file backup

set expandtab " tag bytes are teh evil

" Git like spaces highlighting.
let c_space_errors=1
highlight RedundantSpaces ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/
