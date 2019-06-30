" Phillip Vo

" PLUGINS {{{
call plug#begin('~/.vim/plugged')

" Git
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
" Text Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
" Notes
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'dhruvasagar/vim-table-mode'
Plug 'dkarter/bullets.vim'
" Navigating
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'

call plug#end()
" }}}
" LEADER {{{1
let mapleader="," " leader is comma

" Markdown Headings {{{2
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 ^i### <esc>
nnoremap <leader>4 ^i#### <esc>
nnoremap <leader>5 ^i##### <esc>
" }}}
" Notes {{{2
nnoremap <leader>pp :!pandoc --pdf-engine=lualatex --filter pandoc-citeproc --bibliography=%:r.bib -H ~/resources/notes.tex -o %:r.pdf %<CR>
" }}}
" Quickediting {{{2
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<CR>
" }}}
" Files {{{2
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :q!<cr>
nnoremap <leader>Z :wq!<cr>
" }}}
" }}}
" AUTOGROUPS {{{
augroup filetypes
    au!

    au BufNewFile,BufRead *.md setlocal ft=markdown.tex

    au Filetype gitcommit setlocal spell

    au FileType python setlocal ts=4 sts=4 sw=4 et ai si cinwords=if,elif,else,for,while,try,except,finally,def,class foldmethod=indent foldlevel=99

    au FileType c,cpp let b:AutoPairs = AutoPairsDefine({'/*' : '*/'})

    au FileType pandoc setlocal syn=off
    au FileType pandoc let b:autopairs_enabled = 0
augroup END

augroup NERDTree
    au!
    au StdinReadPre * let s:std_in=1
    au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

augroup QuickfixList
    au!
    au BufEnter * if (winnr("$") == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix") | q | endif
augroup END
" }}}
" OPTIONS {{{1
" Basics {{{2
filetype plugin on

syntax enable " enable syntax processing

set nocompatible

set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set showmatch " highlight matching [{()}]
set cursorline

set number relativenumber  " show hybrid line numbers
set showcmd " show last command in bottom bar
set cursorline " highlight current line

set modeline
set modelines=1

set backspace=2 " backspace over everything
set scrolloff=5

set nobackup
set noswapfile

let g:tex_flavor='latex'
" }}}
" Spellcheck {{{2
set spelllang=en
inoremap <C-l> <C-g>u<Esc>[s1z=`]a<C-g>u
" }}}
" Search {{{2
set ignorecase
set incsearch

nnoremap <leader><space> :noh<cr>
" }}}
" Text Formatting {{{2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent

set list
set listchars=tab:▸\ ,eol:¬

set showbreak=↪
" }}}
" Folding {{{2
set foldenable
set foldmethod=indent
set foldlevelstart=10
set foldnestmax=10

" space open/closes folds
nnoremap <space> za
nnoremap <leader>z zMzvzz
" }}}
" }}}
" THEME {{{
colorscheme gruvbox
set background=dark
" }}}
" NAVIGATING {{{
inoremap jk <esc>
inoremap JK <esc>

" move vertically by visual line (only in normal mode)
nnoremap j gj
nnoremap k gk

" disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" map H/L to move to first/last non-space character of the line
nnoremap H ^
nnoremap L g_

" Open new line above/below current line
nnoremap o o<esc>
nnoremap O O<esc>

" Quickfix List
nnoremap ]q :cnext<cr>
nnoremap [q :cprev<cr>
nnoremap <leader>c :cclose<bar>lclose<cr>
" }}}
" FUNCTIONS {{{1
" Fix Spelling Error {{{2
function! FixLastSpellCheckError()
    normal! mm[s1z=`m
endfunction

nnoremap <leader>sp :call FixLastSpellCheckError()<CR>
"}}}
" }}}
" PANES {{{
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
" }}}
" PLUGINS {{{1
" vim-gitgutter {{{2
set updatetime=100
" }}}
" UltiSnips {{{2
nnoremap <leader>ue :UltiSnipsEdit<cr>

let g:UltiSnipsSnippetDir="~/dotfiles/vim/UltiSnips"
let g:UltiSnipsEditSplit="vertical"

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" }}}
" vim-pandoc {{{2
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#command#autoexec_on_writes = 0
let g:pandoc#command#autoexec_command = "Pandoc pdf --pdf-engine=lualatex -H ~/resources/notes.tex"
let g:pandoc#after#modules#enabled = ["ultisnips", "tablemode"]

nnoremap <leader>pd :pandoc 
" }}}
" Bullets {{{
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \]
" }}}
" NERDTree {{{2
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
map <C-n> :NERDTreeToggle<CR>
" }}}
" Ack.vim {{{
nnoremap <leader>a :Ack! -i<space>
" }}}
" }}}

" vim:foldmethod=marker:foldlevel=0
