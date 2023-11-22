set nocompatible " Disable vi-compatibility

" Install vim-plug if not found
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

" :PlugInstall
" :PlugUpdate
" :PlugClean

call plug#begin('~/.vim/plugged')

"""""""""""""""""""
" General Plugins "
"""""""""""""""""""
" Number the items that are found when searching
Plug 'vim-scripts/IndexedSearch'

" Surround text with stuff
Plug 'tpope/vim-surround'

" Git blame
Plug 'tpope/vim-fugitive'

" Zig highlighting
Plug 'ziglang/zig.vim'

" Jump to letters
Plug 'Lokaltog/vim-easymotion'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

call plug#end()


""""""""""""""""""""
" Display Settings "
""""""""""""""""""""
"let g:solarized_termcolors=256
set t_Co=256 " Explicitly tell vim that the terminal has 256 colors
map <F6> :let &background = ( &background == "dark" ? "light" : "dark" )<CR>
syntax enable
set background=dark
set number
colorscheme PaperColor
"colorscheme solarized

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
"set cursorline

" Highlight the current line with leader c
nnoremap <Leader>c :set cursorline!<CR>

" Cursor crosshair with leader c
"nnoremap <Leader>c :set cursorline cursorcolumn!<CR>

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
