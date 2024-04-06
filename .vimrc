" Install plugins vim-editorconfig vim-fugitive if you want

" needs libenchant-2-voikko voikko-fi packages
let g:vimchant_spellcheck_lang = 'fi'
set updatetime=1001

" sane search
set hlsearch
set ignorecase
set smartcase

" not to save .swp file on dirs, alters directory dates + bad for some systems
" that store all the changes
set directory=~/.vim/swp//,~/tmp,/var/tmp,/tmp
