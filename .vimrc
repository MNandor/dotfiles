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
" Move line up/down
:nnoremap <C-k> <Up>ddp<Up>
:nnoremap <C-j> ddp
:vnoremap <C-k> :m-2<CR>gv
:vnoremap <C-j> :m'>+<CR>gv
" Swap between side-by-side windows and buffers similar to `gt` swapping between tabs
:nnoremap gw <C-w>w
:nnoremap <silent> gb :w<Cr>:bn<Cr>
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
" Cursor shape. Works in xfce4-terminal
let &t_VS = "\<Esc>[2 q" " normal mode, block
let &t_EI = "\<Esc>[2 q" " return to normal mode, block
let &t_SR = "\<Esc>[4 q" " replace mode, underline
let &t_SI = "\<Esc>[5 q" " insert mode, blinking |
autocmd VimLeave * let &t_me="\<Esc>[5 q" " on exit, return terminal to |

let mapleader=' '
