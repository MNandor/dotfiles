"  ____            _      
" | __ )  __ _ ___(_) ___ 
" |  _ \ / _` / __| |/ __|
" | |_) | (_| \__ \ | (__ 
" |____/ \__,_|___/_|\___|

set noexpandtab
set tabstop=4
set shiftwidth=4
" set autoindent
filetype indent on
syntax on
set mouse=a
set incsearch
set hlsearch
set clipboard=unnamedplus
set ignorecase
set smartcase
set splitbelow
set splitright
set linebreak
set breakindent
" set colorcolumn=81


"  __  __                                     _   
" |  \/  | _____   _____ _ __ ___   ___ _ __ | |_ 
" | |\/| |/ _ \ \ / / _ \ '_ ` _ \ / _ \ '_ \| __|
" | |  | | (_) \ V /  __/ | | | | |  __/ | | | |_ 
" |_|  |_|\___/ \_/ \___|_| |_| |_|\___|_| |_|\__|
                                                

" Improved navigation
:nnoremap <S-k> 10k
:vnoremap <S-k> 10k
:nnoremap <S-j> 10j
:vnoremap <S-j> 10j
:nnoremap <S-l> 10l
:nnoremap <S-h> 10h
:nnoremap <C-h> b
:nnoremap <C-l> w
:inoremap <C-a> <C-o>0
:inoremap <C-e> <C-o>$
:inoremap <C-h> <Left>
:inoremap <C-l> <Right>
" :inoremap <C-k> <Up>
" :inoremap <C-j> <Down>

" Move line up/down
:nnoremap <C-k> <Up>ddp<Up>
:nnoremap <C-j> ddp
:vnoremap <C-k> :m-2<CR>gv
:vnoremap <C-j> :m'>+<CR>gv
" Move word left/right
:nnoremap <C-l> diwwPldebhPlw
:nnoremap <C-h> diwgebPldepbhb

" Jump to bookmark
:nnoremap M `

" Swap between side-by-syde windows similar to `gt`
:nnoremap gw <C-w>w

"  _____    _ _ _   _             
" | ____|__| (_) |_(_)_ __   __ _ 
" |  _| / _` | | __| | '_ \ / _` |
" | |__| (_| | | |_| | | | | (_| |
" |_____\__,_|_|\__|_|_| |_|\__, |
"                           |___/ 

" Duplciate
:nnoremap <C-d> yyp
" Search for word at cursor
:nnoremap <C-e> *
" Replace word at cursor
:nnoremap <C-f> :%s/\<<C-r><C-w>\>//gc<Left><Left><left>

" Toggle numbers
function CycleNumbers()
	" Cycle between: no number, both, absolute-only
	if ((&nu == 0) && (&rnu == 0))
		set nu
		set rnu
	elseif ((&nu == 1) && (&rnu == 1))
		set rnu!
	elseif ((&nu == 1) && (&rnu == 0))
		set nu!
	else
		set rnu!
	endif
endfunction
:nnoremap <C-n> :call CycleNumbers()<Cr>

" Tab Indenting
:nnoremap <Tab> >>
:vnoremap <Tab> >gv
:nnoremap <S-Tab> <<
:vnoremap <S-Tab> <gv

" Backspace
:nnoremap x "_x
:nmap <BS> hx
" Remap a to insert a single character
nnoremap a i_<Esc>r

" Delete without overwriting clipboard
:nnoremap X "_d
:nnoremap XX "_dd

" Prevent current line from being at the very top/bottom of screen
" Fun idea: set to 999 for typewriter mode
set scrolloff=5

" To go with ZZ and ZQ shortcuts
:nnoremap ZS :w<Cr>

" Shift-R is overridden, use gR for original
:nnoremap gR R

" Show whitespace on :set list
:set listchars+=tab:-->,space:␣,multispace:___-,extends:~

"     _         _                                  _      _       
"    / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ | | ___| |_ ___ 
"   / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ \| |/ _ \ __/ _ \
"  / ___ \ |_| | || (_) | (_| (_) | | | | | | |_) | |  __/ ||  __/
" /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_| .__/|_|\___|\__\___|
"                                           |_|                   

" Autocomplete
set completeopt=menuone,longest
:inoremap <S-Tab> <C-p>
:inoremap <expr> <CR> pumvisible() ? "<Space>" : "<CR>"
:inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
:inoremap <expr> <Up> pumvisible() ? "<C-p>" : "<Up>"
:inoremap <expr> <Down> pumvisible() ? "<C-n>" : "<Down>"
:inoremap <C-f> <C-x><C-f>

" Spellcheck
:inoremap <C-b> <C-x>s
:noremap <C-b> [sz=

" Complete HTML tag under cursor
autocmd FileType html inoremap ?? <Esc>bi__<Esc>yiw:s/<C-R>"/<&>@@<\/&><Cr>:s/__//g<Cr>/@@<Cr>xxi

" Complete Latex tag under cursor
autocmd FileType tex inoremap ?? <Esc>bi__<Esc>yiw:s/<C-R>"/\\begin{&}\r@@\r\\end{&}<Cr>:.-2,.s/__//g<Cr>/@@<Cr>xxi

" Change next marker
:nnoremap <Space><Space> /<@@><Cr>"_c4l

" Abbreviations
ab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
ab bfox The quick, brown fox jumps over the lazy dog.
autocmd FileType markdown ab cb - [ ]

"  _____                     _       
" | ____|_  _____  ___ _   _| |_ ___ 
" |  _| \ \/ / _ \/ __| | | | __/ _ \
" | |___ >  <  __/ (__| |_| | ||  __/
" |_____/_/\_\___|\___|\__,_|\__\___|
                                   
" Open Terminal
:noremap s :! 
:noremap <S-s> :sh<CR>

" Run file
:nnoremap <S-r> :w<cr>:!clear;"%:p"<cr>
:vmap <S-r> <Esc><S-r>

" Run script (works with bash and python)
:noremap <S-s> :sh<CR>

" Run other languages
autocmd FileType tex nnoremap <S-r> :w<Cr>:!pdflatex "%"<Cr>
autocmd FileType html nnoremap <S-r> :w<Cr>:silent !firefox % &<Cr>
autocmd FileType c nnoremap <S-r> :w<Cr>:!gcc % && ./a.out<Cr>
autocmd FileType cpp nnoremap <S-r> :w<Cr>:!g++ $(ls %:h/*.cpp) && ./a.out<Cr>
autocmd FileType c nnoremap <S-r> :w<Cr>:!gcc $(ls %:h/*.c) && ./a.out<Cr>

" Execute arbitrary vim commands in file
" Obviously this is dangerous - only use on your own files
function LoadVim()
	exec('g/^[^ ]*vim \(.*\)$/norm ^f ly$:"')
endfunction
nnoremap gc :call LoadVim()<Cr>


" source ~/.vim/mnvim/markdown.vim


"  ____                                                _             
" |  _ \ _ __ ___   __ _ _ __ __ _ _ __ ___  _ __ ___ (_)_ __   __ _ 
" | |_) | '__/ _ \ / _` | '__/ _` | '_ ` _ \| '_ ` _ \| | '_ \ / _` |
" |  __/| | | (_) | (_| | | | (_| | | | | | | | | | | | | | | | (_| |
" |_|   |_|  \___/ \__, |_|  \__,_|_| |_| |_|_| |_| |_|_|_| |_|\__, |
"                  |___/                                       |___/ 

" Line numbers in programming languages
autocmd FileType python,vim,sh set nu | set rnu

" Auto add shebangs to new file
autocmd BufNewFile *.py norm O#!/bin/python3
autocmd BufNewFile *.sh norm O#!/bin/bash

" Joplin sometimes doesn't detect vim saves - update manually
autocmd BufWritePost *.md silent :execute "!touch %"

" Toggle comments
" Note: the normal mode uses Visual mode too
" Todo: this break with the second use, because [count]V doesn't select [count] lines but rather [count]*gv lines
" This is to handle cases with and without a line count
autocmd FileType python,sh nnoremap <C-_> <S-v>:g/^\s*[^ \t#].*$/s/^.*$/## &/<Cr>gv:s/^\(\s*\)# \?\(.*\)$/\1\2/<Cr>:noh<Cr>
autocmd FileType python,sh vnoremap <C-_> :g/^\s*[^ \t#].*$/s/^.*$/## &/<Cr>gv:s/^\(\s*\)# \?\(.*\)$/\1\2/<Cr>:noh<Cr>gv
autocmd FileType tex nnoremap <C-_> <S-v>:g/^\s*[^ \t%].*$/s/^.*$/%% &/<Cr>gv:s/^\(\s*\)% \?\(.*\)$/\1\2/<Cr>:noh<Cr>
autocmd FileType tex vnoremap <C-_> :g/^\s*[^ \t%].*$/s/^.*$/%% &/<Cr>gv:s/^\(\s*\)% \?\(.*\)$/\1\2/<Cr>:noh<Cr>gv
autocmd FileType vim nnoremap <C-_> <S-v>:g/^\s*[^ \t"].*$/s/^.*$/"" &/<Cr>gv:s/^\(\s*\)" \?\(.*\)$/\1\2/<Cr>:noh<Cr>
autocmd FileType vim vnoremap <C-_> :g/^\s*[^ \t"].*$/s/^.*$/"" &/<Cr>gv:s/^\(\s*\)" \?\(.*\)$/\1\2/<Cr>:noh<Cr>gv
autocmd FileType java,c,cpp nnoremap <C-_> <S-v>:g#^\s*[^ \t\/\/].*$#s#^.*$#\/\/\/\/ &#<Cr>gv:s#^\(\s*\)\/\/ \?\(.*\)$#\1\2#<Cr>:noh<Cr>
autocmd FileType java,c,cpp vnoremap <C-_> :g#^\s*[^ \t\/\/].*$#s#^.*$#\/\/\/\/ &#<Cr>gv:s#^\(\s*\)\/\/ \?\(.*\)$#\1\2#<Cr>:noh<Cr>gv
autocmd FileType html nnoremap <C-_> <S-v>:g/^<!--\(.*\)-->$/s/^<!--\(.*\)-->$/\1#<Cr>gv:g/^\(.*[^#]\)$/s/^\(.*[^#]\)$/<!--\1-->#<Cr>gv:g/^\(.*\)#$/s/^\(.*\)#$/\1<Cr>:noh<Cr>
autocmd FileType html vnoremap <C-_> :g/^<!--\(.*\)-->$/s/^<!--\(.*\)-->$/\1#<Cr>gv:g/^\(.*[^#]\)$/s/^\(.*[^#]\)$/<!--\1-->#<Cr>gv:g/^\(.*\)#$/s/^\(.*\)#$/\1<Cr>:noh<Cr>gv
autocmd FileType python,sh set list
autocmd FileType python,sh set listchars=tab:\|\ \ 

"  ____  _             _           
" |  _ \| |_   _  __ _(_)_ __  ___ 
" | |_) | | | | |/ _` | | '_ \/ __|
" |  __/| | |_| | (_| | | | | \__ \
" |_|   |_|\__,_|\__, |_|_| |_|___/
"                |___/             

let mapleader=' '

:nnoremap <leader>nt :NERDTreeToggle<cr>
:nnoremap <leader>gg :GitGutterToggle<cr>
let g:table_mode_corner='|'
