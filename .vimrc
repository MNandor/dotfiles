"  ____            _      
" | __ )  __ _ ___(_) ___ 
" |  _ \ / _` / __| |/ __|
" | |_) | (_| \__ \ | (__ 
" |____/ \__,_|___/_|\___|

set noexpandtab
set tabstop=4
set shiftwidth=4
set smartindent
syntax on
set mouse=a
set incsearch
set hlsearch
set clipboard=unnamedplus
set ignorecase
set smartcase
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
:inoremap <C-k> <Up>
:inoremap <C-j> <Down>

" Move line up/down
:nnoremap <C-k> <Up>ddp<Up>
:nnoremap <C-j> ddp
:vnoremap <C-k> :m-2<CR>gv
:vnoremap <C-j> :m'>+<CR>gv

" Jump to bookmark
:nnoremap M `

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
:nnoremap <C-n> :set nu!<cr>:set rnu!<cr>

" Tab Indenting
:nnoremap <Tab> >>
:vnoremap <Tab> >gv
:nnoremap <S-Tab> <<
:vnoremap <S-Tab> <gv

" Backspace
:nnoremap <BS> hx

" Line numbers in programming languages
autocmd FileType python set nu | set rnu
autocmd FileType vim set nu | set rnu
autocmd FileType sh set nu | set rnu

" Delete without overwriting clipboard
:nnoremap X "_d
:nnoremap XX "_dd

" Prevent current line from being at the very top/bottom of screen
" Fun idea: set to 999 for typewriter mode
set scrolloff=5

" To go with ZZ and ZQ shortcuts
:nnoremap ZS :w<Cr>

" Auto add shebangs to new file
autocmd BufNewFile *.py norm O#!/bin/python3
autocmd BufNewFile *.sh norm O#!/bin/bash

" Show whitespace on :set list
:set listchars+=tab:-->,space:_,multispace:___-,extends:~

"     _         _                                  _      _       
"    / \  _   _| |_ ___   ___ ___  _ __ ___  _ __ | | ___| |_ ___ 
"   / _ \| | | | __/ _ \ / __/ _ \| '_ ` _ \| '_ \| |/ _ \ __/ _ \
"  / ___ \ |_| | || (_) | (_| (_) | | | | | | |_) | |  __/ ||  __/
" /_/   \_\__,_|\__\___/ \___\___/|_| |_| |_| .__/|_|\___|\__\___|
"                                           |_|                   

" Autocomplete
set completeopt=menuone,longest
:inoremap <S-Tab> <C-p>
:inoremap <expr> <CR> pumvisible() ? "<C-y>" : "<CR>"
:inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"

" Spellcheck
:inoremap <C-b> <Esc>[sz=
:noremap <C-b> [sz=

" Complete HTML tag under cursor
autocmd FileType html inoremap ?? <Esc>bi__<Esc>yiw:s/<C-R>"/<&>@@<\/&><Cr>:s/__//g<Cr>/@@<Cr>xxi

" Complete Latex tag under cursor
autocmd FileType tex inoremap ?? <Esc>bi__<Esc>yiw:s/<C-R>"/\\begin{&}\r@@\r\\end{&}<Cr>:.-2,.s/__//g<Cr>/@@<Cr>xxi

" Change next marker
:nnoremap <Space><Space> /<@@><Cr>"_c4l

" Abbreviations
ab lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
autocmd FileType markdown ab cb - [ ]

"  _____                     _       
" | ____|_  _____  ___ _   _| |_ ___ 
" |  _| \ \/ / _ \/ __| | | | __/ _ \
" | |___ >  <  __/ (__| |_| | ||  __/
" |_____/_/\_\___|\___|\__,_|\__\___|
                                   
" Open Terminal
:nnoremap s :! 
:nnoremap <S-s> :sh<CR>

" Run file
:nnoremap <S-r> :w<cr>:!clear;"%:p"<cr>

" Run latex
autocmd FileType tex nnoremap <S-r> :w<Cr>:!pdflatex "%"<Cr>
autocmd FileType html nnoremap <S-r> :w<Cr>:silent !firefox % &<Cr>

source ~/.vim/mnvim/*
