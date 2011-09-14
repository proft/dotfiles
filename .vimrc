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
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

filetype on
filetype plugin on

set nocompatible
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines

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
set cursorline nu

" current command going on
set showcmd

" not unload buffer
set hidden

set pastetoggle=<F5>
set completeopt=longest,menuone

" mapping
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
nnoremap <leader>z zMa<esc>

" fold tag
nnoremap <leader>ft Vatzf

" re-hardwrap paragraphs of text
nnoremap <leader>q gqip

" reselect the text
nnoremap <leader>v V`]

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
inoremap <C-l> <esc>lC
inoremap <C-w> <esc>cw
inoremap <C-b> <esc>cb

" easy window navigation
nnoremap j gj
nnoremap k gk

" windows
map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>w <C-w>v<C-w>l

" line move
nnoremap <C-j> :m+<CR>==
nnoremap <C-k> :m-2<CR>==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=gv
vnoremap <C-k> :m-2<CR>gv=gv

" switches match highlighting on and off
nmap <F6> :set hls!<CR>

" copy current path
function CopyPath()
    let @* = expand("%:p:h")
endfunction
map <leader>p :call CopyPath()<CR>

" open url in chromium-browser
function! Browser ()
  let line = matchstr(getline("."), 'http:\/\/[^ >,;:]*')
  exec ":silent !chromium-browser ".line
endfunction
map <Leader>o :call Browser ()<CR>

" correct filetype
map <Leader>tm :set ft=markdown<CR>
map <Leader>td :set ft=htmldjango<CR>

" switches wrap
nmap <F8> :set wrap!<CR>

" switch buffer
map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>

" Setting up the command mode in russian layout
map ё `
map й q
map ц w
map у e
map к r
map е t
map н y
map г u
map ш i
map щ o
map з p
map х [
map ъ ]
map ф a
map ы s
map в d
map а f
map п g
map р h
map о j
map л k
map д l
map ж ;
map э '
map я z
map ч x
map с c
map м v
map и b
map т n
map ь m
map б ,
map ю .
map Ё ~
map Й Q
map Ц W
map У E
map К R
map Е T
map Н Y
map Г U
map Ш I
map Щ O
map З P
map Х {
map Ъ }
map Ф A
map Ы S
map В D
map А F
map П G
map Р H
map О J
map Л K
map Д L
map Ж :
map Э "
map Я Z
map Ч X
map С C
map М V
map И B
map Т N
map Ь M
map Б <
map Ю >

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

cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" *** pep8 ***
let g:pep8_map='<leader>8'
