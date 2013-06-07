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

" Visible whitespace
set listchars=tab:»·,trail:·
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
" Rails.vim extensions
"=============================================

autocmd User Rails Rnavcommand decorator app/decorators -suffix=_decorator.rb -default=model()
autocmd User Rails Rnavcommand presenter app/presenters -suffix=_presenter.rb -default=model()
autocmd User Rails Rnavcommand uploader app/uploaders -suffix=_uploader.rb -default=model()
autocmd User Rails Rnavcommand steps features/step_definitions -suffix=_steps.rb -default=web
autocmd User Rails Rnavcommand factory spec/factories -suffix=_factory.rb -default=model()
autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()
autocmd User Rails Rnavcommand feature features -suffix=.feature -default=cucumber
autocmd User Rails Rnavcommand support spec/support features/support -default=env
autocmd User Rails Rnavcommand worker app/workers -suffix=_worker.rb -default=model()

"=============================================
" Additional Config Files
"=============================================

" Load user settings
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

"=============================================
" Rails.vim projections
"=============================================

if !exists('g:rails_projections')
  let g:rails_projections = {}
endif

call extend(g:rails_projections, {
      \ "app/presenters/*.rb": {
      \   "command": "presenter",
      \   "test": "spec/presenter/%s_spec.rb",
      \   "alternate": "spec/presenter/%s_spec.rb",
      \   "template": "class %S\nend" },
      \ "app/workers/*.rb": {
      \   "command": "worker",
      \   "template": "class %S\nend" }
      \ }, 'keep')

if !exists('g:rails_gem_projections')
  let g:rails_gem_projections = {}
endif

call extend(g:rails_gem_projections, {
      \ "active_model_serializers": {
      \   "app/serializers/*_serializer.rb": {
      \     "command": "serializer",
      \     "template": "class %SSerializer < ActiveModel::Serializer\nend",
      \     "affinity": "model"}},
      \ "rspec": {
      \   "spec/support/*.rb": {
      \     "command": "support"}},
      \ "cucumber": {
      \   "features/*.feature": {
      \     "command": "feature",
      \     "template": "Feature: %h"},
      \   "features/support/*.rb": {
      \     "command": "support"},
      \   "features/support/env.rb": {
      \     "command": "support"},
      \   "features/step_definitions/*_steps.rb": {
      \     "command": "steps"}},
      \ "carrierwave": {
      \   "app/uploaders/*_uploader.rb": {
      \     "command": "uploader",
      \     "template": "class %SUploader < CarrierWave::Uploader::Base\nend"}},
      \ "draper": {
      \   "app/decorators/*_decorator.rb": {
      \     "command": "decorator",
      \     "affinity": "model",
      \     "template": "class %SDecorator < ApplicationDecorator\nend"}},
      \ "fabrication": {
      \   "spec/fabricators/*_fabricator.rb": {
      \     "command": ["fabricator", "factory"],
      \     "alternate": "app/models/%s.rb",
      \     "related": "db/schema.rb#%p",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "Fabricator :%s do\nend",
      \     "affinity": "model"}},
      \ "factory_girl": {
      \   "spec/factories/*_factory.rb": {
      \     "command": "factory",
      \     "alternate": "app/models/%s.rb",
      \     "related": "db/schema.rb#%p",
      \     "test": "spec/models/%s_spec.rb",
      \     "template": "FactoryGirl.define do\n  factory :%s do\n  end\nend",
      \     "affinity": "model"},
      \   "spec/factories.rb": {
      \      "command": "factory"},
      \   "test/factories.rb": {
      \      "command": "factory"}}
      \ }, 'keep')
