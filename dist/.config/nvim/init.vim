set nocompatible

" undo history
set history=500
set undolevels=500
set undofile

" line numbers
set relativenumber
set number

" split style
set splitbelow
set splitright

" viewport
set textwidth=80
set colorcolumn=+1

" invisibles
set list
set listchars=tab:»\ ,trail:·,nbsp:·

" keybindings

" leader
let mapleader = "\<Space>"
nnoremap <SPACE> <Nop>

nnoremap ; :
nnoremap : ;

" navigation
inoremap <c-k> <up>
inoremap <c-j> <down>
inoremap <c-h> <left>
inoremap <c-l> <right>

" buffers navigation
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>

nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>l :bnext<CR>

" splits
nnoremap <Leader>\ :vsp<CR>
nnoremap <Leader>- :sp<CR>

" save
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-C>:update<CR>

" scrollwheel
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

"
filetype indent on
filetype plugin on

set noshowmode

" theme
colorscheme gruvbox
