set background=dark
colorscheme solarized

syntax enable
set ts=2
set sw=2
set expandtab
set number
set cursorline
set hidden

if (has('gui_running'))
  set guifont=Inconsolata-dz:h12
  set guioptions-=T
endif

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tabcompete behavior
set wildmenu
set wildmode=list:longest,full
set wildignore=*.exe,*.swp,*.dll,*.o,*.so
