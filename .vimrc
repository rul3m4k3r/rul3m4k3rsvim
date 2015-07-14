set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Own Plugins
Plugin 'scrooloose/nerdtree.git'
Plugin 'scrooloose/syntastic'
Plugin 'nerdtree-ack'
Plugin 'mileszs/ack.vim'
Plugin 'IndexedSearch'
Plugin 'rgarver/Kwbd.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'TaskList.vim'
Plugin 'groenewege/vim-less'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'rodjek/vim-puppet'
Plugin 'Valloric/YouCompleteMe'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'othree/html5.vim'
"Plugin 'AutoComplPop'

call vundle#end()            " required
filetype plugin indent on    " required
set backspace=indent,eol,start
syntax on
set t_Co=256
set number
set ff=unix
set modeline
set tabstop=4 expandtab shiftwidth=4 softtabstop=4
set smartindent
set smarttab
set enc=utf-8
set mouse=nvc
set cursorline
set ai
set nobackup
set nowritebackup
set noswapfile

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_tidy_exec = 'tidy5'
let g:syntastic_python_checkers = ['pylint', 'flake8']
" http://pep8.readthedocs.org/en/latest/intro.html
" E111: whitespace mult of 4
" E121: continuation line mult 4,
" E126: continuation line over-indented for hanging indent
" E127: continuation line over-indented for visual indent
" E203: whitespace before :
" E221: multiple spaces before operator
" E225: whitespace around operator
" E226: whitespace around arithmetic operator
" E501: line too long
let g:syntastic_python_flake8_args = '--ignore=E111,E121,E126,E127,E203,E221,E225,E226,E501'
 
" http://pylint-messages.wikidot.com/all-codes
" W0311: Bad indentation
" C0103: Invalid name for variable
" C0111: Missing docstring
" C0301: Line too long
let g:syntastic_python_pylint_args = '--disable=W0311,C0103,C0111,C0301 --output-format=parseable --include-ids=y --reports=n'

"Indentlines
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['nerdtree']

"YouCompleteMe
"let g:ycm_filetype_whitelist = { 'python':1 }

" no bells
set noeb vb t_vb=

" xoria color scheme
:colo xoria256

" Set standart mapping
:let mapleader = ","

" Insert statusline from fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Nerdtree show bookmarks on startup
:let NERDTreeShowBookmarks=1

" MiniBuffExplorer
:let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

" Map Ctrl C to close buffer without Window
map <C-c> <esc>:mbc<enter>

" Map Ctrl T to TagList
map <C-t> <esc>:TlistToggle<enter>

" Map Ctrl N to NerdTree
map <C-n> <esc>:NERDTreeToggle<enter>

" Remove dos formatting
map <C-d> <esc>:%s/[ctrl v][ctrl[m]//g

" Close Buffer without change layout
nmap <Leader>w <esc>:Kwbd<enter>

"Surround Django Key Mappings
let b:surround_{char2nr("v")} = "{{ \r }}"
let b:surround_{char2nr("{")} = "{{ \r }}"
let b:surround_{char2nr("%")} = "{% \r %}"
let b:surround_{char2nr("b")} = "{% block \1block name: \1 %}\r{% endblock \1\1 %}"
let b:surround_{char2nr("i")} = "{% if \1condition: \1 %}\r{% endif %}"
let b:surround_{char2nr("w")} = "{% with \1with: \1 %}\r{% endwith %}"
let b:surround_{char2nr("f")} = "{% for \1for loop: \1 %}\r{% endfor %}"
let b:surround_{char2nr("c")} = "{% comment %}\r{% endcomment %}"

"au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au FileType scss set omnifunc=csscomplete#CompleteCSS

"""" Autocommands
if has("autocmd")
augroup vimrcEx
au!
	" smart indenting for python
	au FileType python set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
	autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
	set iskeyword+=.,_,$,@,%,#
	au FileType python set expandtab
	
	" kill calltip window if we move cursor or leave insert mode
	au CursorMovedI * if pumvisible() == 0|pclose|endif
	au InsertLeave * if pumvisible() == 0|pclose|endif
	augroup END
endif
""" Delete Whitespaces at the end of a line in Python
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
