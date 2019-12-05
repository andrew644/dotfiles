set nocompatible " Disable vi-compatibility

" Load vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" :PlugInstall
" :PlugUpdate
" :PlugClean
call plug#begin('~/.vim/plugged')

"""""""""""""""""""
" General Plugins "
"""""""""""""""""""
" Surround text with stuff
Plug 'tpope/vim-surround'
" Gblame
Plug 'tpope/vim-fugitive'
" Better directory tree management
Plug 'scrooloose/nerdtree'
" Better fuzzy search for files
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Jump to letters
Plug 'Lokaltog/vim-easymotion'
" Number the items that are found when searching
Plug 'vim-scripts/IndexedSearch'

""""""""""""
" Cosmetic "
""""""""""""
" Airline color schemes
Plug 'vim-airline/vim-airline-themes'
" Solarized color scheme
Plug 'altercation/vim-colors-solarized'
" Paper color theme
Plug 'NLKNguyen/papercolor-theme'
" Light weight interface improvement
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""""""""""""""""
" Rust Plugins "
""""""""""""""""
" Syntax and autoformat
Plug 'rust-lang/rust.vim'

""""""""""""""
" Go Plugins "
""""""""""""""
" Syntax and autoformat
Plug 'fatih/vim-go'

"""""""""
" Latex "
"""""""""
Plug 'lervag/vimtex'
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

" Add plugins to &runtimepath
filetype plugin indent on
call plug#end()

""""""""""""""""""""
" Display Settings "
""""""""""""""""""""
"let g:solarized_termcolors=256
map <F6> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors
set background=light
set number
colorscheme PaperColor

"""""""""""""""""""
" Editor Settings "
"""""""""""""""""""
" Set indentation settings
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
" Use spaces for python
autocmd Filetype python setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
" Use spaces for rust
autocmd Filetype rust setlocal expandtab tabstop=4 shiftwidth=4

" Switch buffers without having to save them first
set hidden

" Open zip archives that don't use .zip extension
au BufReadCmd *.jar,*.spk call zip#Browse(expand("<amatch>"))

" Highlighting in search
set incsearch
set hlsearch
" better search
set ignorecase
set smartcase

" Normal backspace behavior
set backspace=indent,eol,start

" Set persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Show whitespace
set nolist
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•,eol:¬
" F7: toggle display of tabs/spaces/etc
nmap <F7> :set list!<return>
highlight ExtraWhitespace ctermbg=lightred guibg=lightred
" highlight trailing spaces if you're not currently typing and highlight spaces before tabs
autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/ containedin=ALL

" Toggle spell checking
nmap <F1> :set spell!<return>

" Always highlight the current line
set cursorline

" Cursor crosshair with leader c
nnoremap <Leader>c :set cursorline cursorcolumn!<CR>

" set the leader key
map <SPACE> <leader>
" show when leader has been hit
set showcmd

" move left and right through the open buffers
nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>"

"move up and down through word wrapped lines
nnoremap j gj
nnoremap k gk

"""""""""""""""""""
" Plugin Settings "
"""""""""""""""""""

"""""""""""""""
" Easy Motion "
"""""""""""""""
map <Leader> <Plug>(easymotion-prefix)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" " Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

"""""""""""
" Airline "
"""""""""""
" show airline all the time
set laststatus=2
"  populate the g:airline_symbols dictionary with the powerline symbols
let g:airline_powerline_fonts = 1
let g:airline_theme = 'papercolor'
let g:airline#extensions#branch#enabled = 1
" Enable the list of buffers at the top
let g:airline#extensions#tabline#enabled = 1
" Hide > and < seperators
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" Don't show whitespace errors
let g:airline#extensions#whitespace#enabled = 0

" Number buffers and switch to them with leader+num
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"""""""
" FZF "
"""""""
nmap <leader>p :FZF<cr>

""""""""""""
" Rust.vim "
""""""""""""
" Enable autoformat
let g:rustfmt_autosave = 1
