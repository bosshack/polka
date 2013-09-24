scriptencoding utf-8

"=============================================
" Initialization
"=============================================

" Load user settings
if filereadable(expand('~/.vimrc.plugin_settings'))
  source ~/.vimrc.plugin_settings
endif

" Load pathogen if it is found
if filereadable(expand('~/.vim/bundle/vim-pathogen/autoload/pathogen.vim'))
  source ~/.vim/bundle/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect()
endif

" Setup go
set runtimepath+=$GOROOT/misc/vim

" Start .vimrc
set nocompatible
filetype plugin indent on

"=============================================
" Options
"=============================================

" Enable utf-8
set encoding=utf-8

" Color
set t_Co=256
set background=dark
colorscheme base16-default
syntax on

" Turn off error bells
set noerrorbells
set visualbell
set t_vb=

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Tab completion
set wildmode=list:longest,full
set wildignore=*.swp,*.o,*.so,*.exe,*.dll
set wildmenu

" Scroll
set scrolloff=3

" Tab settings
set ts=2
set sw=2
set expandtab

" Hud
set ruler
set number
set cursorline
set laststatus=2 " Always show status bar
set nowrap
set colorcolumn=80

" Visible whitespace
set listchars=tab:\ \ ,trail:·
set list

" Buffers
set hidden

" History
set history=1000
set undolevels=1000

" Backup Directories
set backupdir=~/.vim/backups,.
set directory=~/.vim/swaps,.
if exists('&undodir')
  set undodir=~/.vim/undo,.
endif

" Fix backspace
set backspace=indent,eol,start

" GUI options
if (has('gui_running'))
  set guifont=Inconsolata-dz:h12
  set guioptions-=T
  set guioptions-=m
endif

"=============================================
" Remaps
"=============================================

let mapleader=','
let maplocalleader=','

" No arrow keys
map <Left>  :echo "ಠ_ಠ"<cr>
map <Right> :echo "ಠ_ಠ"<cr>
map <Up>    :echo "ಠ_ಠ"<cr>
map <Down>  :echo "ಠ_ಠ"<cr>

" Jump key
nnoremap ` '
nnoremap ' `

" Change pane
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Turn off search highlight
nnoremap <localleader>/ :nohlsearch<CR>

" Trim trailing whitespace
nnoremap <localleader>ws m`:%s/\s\+$//e<CR>``

"=============================================
" Additional Config Files
"=============================================

" Load user settings
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

