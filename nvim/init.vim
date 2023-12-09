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
" Better directory tree management
Plug 'scrooloose/nerdtree'

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

" Show help for leader key
Plug 'liuchengxu/vim-which-key'

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
set cursorline

" Highlight the current line with leader c
"nnoremap <Leader>c :set cursorline!<CR>

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

"""""""
" COC "
"""""""
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')


""""""""""""
" WhichKey "
""""""""""""
"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
"let g:mapleader = "\<Space>"
"let g:maplocalleader = ','
"nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
"nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
