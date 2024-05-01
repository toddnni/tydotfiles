" Install plugins vim-editorconfig vim-fugitive if you want

" needs libenchant-2-voikko voikko-fi packages
let g:vimchant_spellcheck_lang = 'fi'
set updatetime=1001

" sane search
set hlsearch
set ignorecase
set smartcase

" For tmux, it does not interpret the background color of the terminal
" correctly and the default color scheme is off
" (could be related to bce or not, see below)
" https://unix.stackexchange.com/questions/348771/why-do-vim-colors-look-different-inside-and-outside-of-tmux
set background=dark

" not to save .swp file on dirs, alters directory dates + bad for some systems
" that store all the changes
set directory=~/.vim/swp//,~/tmp,/var/tmp,/tmp
