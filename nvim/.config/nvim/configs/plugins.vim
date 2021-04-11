
"#####################################################################################################
"                           ____     __                     _                 
"                          / __ \   / /  __  __   ____ _   (_)   ____    _____
"                         / /_/ /  / /  / / / /  / __ `/  / /   / __ \  / ___/
"                        / ____/  / /  / /_/ /  / /_/ /  / /   / / / / (__  ) 
"                       /_/      /_/   \__,_/   \__, /  /_/   /_/ /_/ /____/  
"                                              /____/
"######################################################################################################

" Install vim-plugged if not already installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" LaTeX support
Plug 'lervag/vimtex'

" Git wrapper
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

" Nerd Commenter
Plug 'scrooloose/nerdcommenter'

" Code Snippets Engine
" Plug 'SirVer/ultisnips'

" Snippets for ultisnips
Plug 'honza/vim-snippets'

" Vim Surround
Plug 'tpope/vim-surround'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

"" Indent guides
Plug 'Yggdroot/indentLine'

" COC
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Smart completion (to work with CoC)
"Plug 'zxqfl/tabnine-vim'

" Custom start page
Plug 'mhinz/vim-startify'

" Vim Javascript
Plug 'pangloss/vim-javascript'

" Language Packs
Plug 'sheerun/vim-polyglot'

" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Tabular auto-align
Plug 'godlygeek/tabular'

" Add DevIcons
Plug 'ryanoasis/vim-devicons'

" Tagbar
Plug 'liuchengxu/vista.vim'

" NERDTree
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Emoji support
Plug 'junegunn/vim-emoji'

" goyo distraction free mode
Plug 'junegunn/goyo.vim'

" Wal theme
Plug 'dylanaraps/wal.vim'
Plug 'deviantfero/wpgtk.vim'

" Translator
Plug 'voldikss/vim-translator'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" vim-hexcolor
Plug 'etdev/vim-hexcolor'

" codi interactive scratchpad
" Temporary repo, may be deprecated
Plug 'ChristianChiarulli/codi.vim'

" Easy tables in vim
Plug 'dhruvasagar/vim-table-mode'

" Fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" emmet-vim
Plug 'mattn/emmet-vim'

" cht.sh-vim
Plug 'dbeniamine/cheat.sh-vim'

call plug#end()
