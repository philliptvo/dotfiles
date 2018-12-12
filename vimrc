" LOADING
execute pathogen#infect()

" LEADER
let mapleader="," " leader is comma

" FILETYPE PLUGINS
filetype plugin on

" THEME & LAYOUT
colorscheme material
set number relativenumber  " show hybrid line numbers
set showcmd " show last command in bottom bar
set cursorline " highlight current line
syntax enable " enable syntax processing

set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set showmatch " highlight matching [{()}]

" SEARCHING
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

" TEXT FORMATTING
set tabstop=4
set softtabstop=4
set expandtab
set autoindent

" NAVIGATING
" move vertically by visual line (only in normal mode)
nnoremap j gj
nnoremap k gk
" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" set $/^ to no do anything (only in normal mode)
" nnoremap $ <nop>
" nnoremap ^ <nop>

" switch tabs
nnoremap <C-h> <C-w><C-h>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

" jk is escape (only for insert mode)
inoremap jk <esc>
inoremap JK <esc>

" FOLDING
set foldenable
set foldlevelstart=10
set foldnestmax=10
" space open/closes folds
nnoremap <space> za

" FZF
map ; :FZF<CR>

" GITGUTTER
set updatetime=100
nnoremap <leader>g :GitGutterToggle

" ALE
nnoremap <leader>a :ALEDetail<CR>

" VIMRC
nnoremap <leader>s :source ~/.vimrc<CR>
