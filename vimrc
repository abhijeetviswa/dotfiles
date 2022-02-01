" Basic Settings
set nocompatible
set number relativenumber
set ruler
set autoindent
set hlsearch
set title
set shiftround
set ignorecase
set incsearch
set smartcase
set mouse=a
set wildmenu
set lazyredraw
set showcmd

" Split Settings
set splitright
set splitbelow

" Tab Settings
set tabstop=8
" set expandtab
set shiftwidth=8
set softtabstop=8
set noexpandtab
set cindent
set autoindent
set copyindent
set smartindent

" Keep moving up one directory to find ctags file
set tags=./tags;/

" Plugins
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'vim-scripts/c.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
Plug 'tpope/vim-sensible'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'prabirshrestha/vim-lsp'
Plug 'ajh17/vimcompletesme'
call plug#end()

" Theme
syntax on
colorscheme one
let g:airline_theme='one'
set background=dark
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#mixed_indent_algo = 1
hi Normal guibg=NONE ctermbg=NONE

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Ctrlp
let g:ctrlp_clear_cache_on_exit=0

" Gutentag settings
" let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
" let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" **** KEY MAPS****
let mapleader=' '
" Quickly remove highlights
nnoremap <leader>hl :nohl<CR>
" Quick paste mode toggle
set pastetoggle=<F10>
" quit window window
nnoremap <leader>q :quit<CR>

" NERDTree remaps
nnoremap <leader>n :NERDTreeFocus<CR>
"nnoremap <C-n> :NERDTree<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Tab title = filename
" set guitablabel=\[%N\]\ %t\ %M

" Blinking Cursor
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Strip whitespace on file save
autocmd BufWritePre *.c :%s/\s\+$//e 
" cd on opening buffer
autocmd BufEnter * lcd %:p:h

" Remaps
" Copy to clipboard
vnoremap <leader>y "+y
vnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" Paste from clipboard
vnoremap <leader>p "+p
vnoremap <leader>P "+P
nnoremap <leader>p "+p
nnoremap <leader>P "+P

" Ease of life for windows
nnoremap <leader>w <C-w>
nnoremap <C-w>- :wincmd s<cr>
nnoremap <C-w>\ :wincmd v<cr>

" Easy of life for tabs
nnoremap <tab>n :tabnew<cr>
" goto next/prev tab
nnoremap <tab>q :tabp<cr>
nnoremap <tab>e :tabn<cr>
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Execute macro in vmode
xnoremap Q :'<,'>:normal @q<CR>

" C-v to paste in imode
inoremap <C-v> <C-r>+

" Easy buffer switching
nnoremap <Backspace> <C-^>

" Persistent undos
let s:undodir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undodir)
    call mkdir(s:undodir, "", 0700)
endif
let &undodir=s:undodir
set undofile

" Break indent and movement
"set breakindent
"set breakindentopt=shift:0

" remap j and k to move across breakindents normally
" and fallback to normal movement when use counts
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Equalize splits on terminal resize
autocmd VimResized * wincmd =

" Setup vim-lsp with clangd
if executable('clangd')
    augroup lsp_clangd
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'clangd',
                    \ 'cmd': {server_info->['clangd']},
                    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
                    \ })
        autocmd FileType c setlocal omnifunc=lsp#complete
        autocmd FileType cpp setlocal omnifunc=lsp#complete
        autocmd FileType objc setlocal omnifunc=lsp#complete
        autocmd FileType objcpp setlocal omnifunc=lsp#complete
    augroup end
endif
