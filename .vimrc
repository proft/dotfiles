" proft vim config [http://proft.me]

syntax on
set nu
set t_Co=256
"colorscheme calmar256-dark
colorscheme lucius

" *** xptemplate ***
let g:xptemplate_brace_complete=0

" pathogen
filetype off
"call pathogen#runtime_append_all_bundles()
call pathogen#incubate()
call pathogen#helptags()

filetype on
filetype plugin on

set encoding=utf-8

" format for status line
set statusline=%<%F%h%m%r%=%y\ (%{&fileformat})\ [%{strlen(&fileencoding)?&fileencoding:'-'}/%{&encoding}]\ %l/%L,%c%V\ %P
set laststatus=2

set mouse=a

set nocompatible
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines

set autoread "Set to auto read when a file is changed from the outside"

" tab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

set novisualbell 
"set cursorline nu

" current command going on
set showcmd

" not unload buffer
set hidden

set pastetoggle=<F5>
set completeopt=longest,menuone

" mapping
"
" save
nnoremap <F4> :w<CR>
inoremap <F4> <esc>:w<CR>a

" nnoremap ; :
inoremap <C-J> <Esc>o
inoremap <C-K> <Esc>O

" no swap & no backup files
set noswapfile nobackup

" encoding
set fileencodings=utf-8,cp1251

" encoding by defaukt
set termencoding=utf-8

" formattage
set autoindent
set smartindent         

" perl/python compatible regex formatting
nnoremap / /\v
vnoremap / /\v

" use tab for move
nnoremap <tab> %
vnoremap <tab> %

let mapleader = ","

" folding
nnoremap <Space> za
vnoremap <Space> za
nnoremap <A-space> zA
nnoremap <leader>z zMa<esc>

" fold tag
nnoremap <leader>ft Vatzf

" re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" reselect the text
nnoremap <leader>v V`]

" kill window
nnoremap K :q<cr>

" delete end marker
nnoremap <leader>m <Esc>:%s/\r//g<CR>

" change current dir
nnoremap <leader>d <Esc>:cd %:p:h<CR>

" backspace in Visual mode deletes selection
vnoremap <BS> d

" new line after, beore
inoremap <C-o> <ESC>O
inoremap <C-p> <ESC>o

" delete current line
nnoremap <C-d> dd
inoremap <C-d> <esc>ddi
" inoremap <C-l> <esc>lC
" inoremap <C-w> <esc>cw
" inoremap <C-b> <esc>cb

" delete to the blackhole register
nnoremap <Leader>d "_d

" easy line navigation
nnoremap j gj
nnoremap k gk

" windows
map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" move a line of text using ALT+[jk], indent with ALT+[hl]
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
nnoremap <C-h> <<
nnoremap <C-l> >>
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
inoremap <C-h> <Esc><<`]a
inoremap <C-l> <Esc>>>`]a
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv
vnoremap <C-h> <gv
vnoremap <C-l> >gv

" hide startup message
set shortmess+=I

" switches match highlighting on and off
nmap <F7> :set hls!<CR>

"copy current file name
nmap <Leader>f :let @+ = expand('%:t')<CR>

"copy current file directory
nmap <Leader>F :let @+ = expand('%:p:h')<CR>

" open url in chromium-browser
function! Browser ()
  let line = matchstr(getline("."), 'http:\/\/[^ >,;:]*')
  exec ":silent !chromium ".line
endfunction
map <Leader>o :call Browser ()<CR>

" correct filetype
"map <Leader>tm :set ft=markdown<CR>
"map <Leader>td :set ft=htmldjango<CR>
nmap <Leader>ft :set ft=
nmap <Leader>fh :set ft=html<CR>

" switches wrap
nmap <F9> :set wrap!<CR>

" switch buffer
map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>

" Setting up the command mode in russian layout
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

" heading
map h1 yypVr=o

" [ABBREVIATIONS]

iabbrev cl console.log();
iabbrev b0 border: 1px solid red;
iabbrev ddate <C-R>=strftime("%d.%m.%Y")<CR>
iabbrev ttime <C-R>=strftime("M:%S")<CR>

cmap w!! w !sudo tee % >/dev/null
cmap W w
cmap Q q
cmap Wa wa
cmap WA wa
cmap Wq wq

"cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" *** close tag ***
autocmd FileType html,htmldjango,jinjahtml let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml source ~/.vim/bundle/closetag/plugin/closetag.vim

" *** ctrlp ***
nmap <F3> :CtrlPMRU<cr>
nmap <C-b> :CtrlPBuffer<cr>

" Open goto file
nmap <C-p> :CtrlP<cr>
imap <C-p> <esc>:CtrlP<cr>
