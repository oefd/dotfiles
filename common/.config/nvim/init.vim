""" plug auto-setup
let plug_dir = '~/.config/nvim'
if empty(glob(plug_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.plug_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.config/nvim/plug')

""" plugins
" aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-buftabline'
" utility
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"syntax
Plug 'hashivim/vim-terraform'
" completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

""" plug auto-install
call plug#end()
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

""" plugin config
" lightline
let g:lightline = {
            \ 'colorscheme': 'nord'
            \ }
" terraform
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1

""" generic
filetype plugin indent on
syntax enable

set clipboard+=unnamedplus " share buffer with OS
set hidden                 " don't unload hidden buffers
set modeline               " allow magic modelines
set noshowmode             " hide mode (lightline shows it already)
set signcolumn=yes         " always render left-side gutter
set number                 " always show line numbers

set nobackup
set nowritebackup

set completeopt=menu,menuone,noselect

set termguicolors
set t_Co=256
colorscheme nord

""" keybinds
let mapleader = ";"
let maplocalleader = ","
nnoremap <silent> <C-n> :bnext<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-l> :nohl<CR>

""" lua
lua << EOF
require('lsp-cmp')
EOF

" vim:et:sw=2:ts=2:
