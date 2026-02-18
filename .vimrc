set noexpandtab
set tabstop=4
set shiftwidth=4
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
set nomodeline
set nrformats+=unsigned
" Cursor shape. Works in xfce4-terminal
let &t_VS = "\<Esc>[2 q" " normal mode, block
let &t_EI = "\<Esc>[2 q" " return to normal mode, block
let &t_SR = "\<Esc>[4 q" " replace mode, underline
let &t_SI = "\<Esc>[5 q" " insert mode, blinking |
autocmd VimLeave * let &t_me="\<Esc>[5 q" " on exit, return terminal to |

let mapleader=' '
