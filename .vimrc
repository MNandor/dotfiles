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


" Move line up/down
:nnoremap <C-k> <Up>ddp<Up>
:nnoremap <C-j> ddp

" Duplciate
:nnoremap <C-d> yyp

" Improved navigation
:nnoremap <S-k> 10k
:nnoremap <S-j> 10j
:nnoremap <S-l> 10l
:nnoremap <S-h> 10h
:nnoremap <C-h> b
:nnoremap <C-l> w

" Jump to bookmark
:nnoremap M `

" Search for word at cursor
:nnoremap <C-e> *
" Replace word at cursor
:nnoremap <C-f> :%s/\<<C-r><C-w>\>//g<Left><left>

" Toggle numbers
:nnoremap <C-n> :set nu!<cr>:set rnu!<cr>

" Run file
" Note - %:p translates to full path - % translates to just file name
:nnoremap <S-r> :w<cr>:!clear;"%:p"<cr>

" Open Terminal
:nnoremap s :! 
:nnoremap <S-s> :sh<CR>


" Tab Indenting
:nnoremap <Tab> >>
:vnoremap <Tab> >>
:nnoremap <S-Tab> <<
:vnoremap <S-Tab> <<

" Backspace
:nnoremap <BS> hx

" Autocomplete
set completeopt=menuone,longest
:inoremap <S-Tab> <C-p>
:inoremap <expr> <CR> pumvisible() ? "<Right>" : "<CR>"
" Complete HTML tag under cursor
:inoremap <C-u> <Esc>diwi<Right><<Esc>pi<Right>></<Esc>pi<Right>><Esc>F/hi


" Not a config since this is default but noting for myself
" C-a / C-x increments/decrements number under cursor
