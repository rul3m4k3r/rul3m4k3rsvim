call pathogen#infect()
call pathogen#helptags()
:filetype plugin on
:filetype plugin indent on
:syntax on
:set t_Co=256
:set number
:set ff=unix
:set modeline
:set tabstop=8 expandtab shiftwidth=4 softtabstop=4
:set smartindent
:set smarttab
:set enc=utf-8
:set mouse=nvc
:set cursorline
:set ai
:set nobackup
:set nowritebackup
:set noswapfile

"Python-Mode
let g:pymode_lint_checker = "pylint,pyflakes,pep8,mccabe"
let g:pymode_syntax_slow_sync = 0
let g:pymode_folding = 0
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

" code(omni)
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python.django set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType htmldjango.html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

""" Key Mappings
" bind ctrl+space for omnicompletion
inoremap <Nul> <C-x><C-o>
imap <c-space> <C-x><C-o>

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


"CoffeeLint
"let coffee_linter = '/usr/local/share/npm/bin/coffeelint'
"au BufWritePost *.coffee CoffeeLint | cwindow | redraw!

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
