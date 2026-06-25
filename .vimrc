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

" Tab Indenting
:nnoremap <Tab> >>
:vnoremap <Tab> >gv
:nnoremap <S-Tab> <<
:vnoremap <S-Tab> <gv
" To go with ZZ and ZQ shortcuts
:nnoremap ZS :w<Cr>


" when vim is launched from lazygit, this stuff is forgotten
" vim then complains about ␣ in listchars
set encoding=utf-8
scriptencoding=utf-8

" Show whitespace on :set list
:set listchars+=tab:-->,space:␣,multispace:___-,extends:~
" Cursor shape. Works in xfce4-terminal
let &t_VS = "\<Esc>[2 q" " normal mode, block
let &t_EI = "\<Esc>[2 q" " return to normal mode, block
let &t_SR = "\<Esc>[4 q" " replace mode, underline
let &t_SI = "\<Esc>[5 q" " insert mode, blinking |
autocmd VimLeave * let &t_me="\<Esc>[5 q" " on exit, return terminal to |

" Replay macro quicker
noremap Q @@
let mapleader=' '

" Plugins
if !empty(globpath(&runtimepath, 'autoload/plug.vim'))
	call plug#begin()

	Plug 'markonm/traces.vim'
	Plug 'tpope/vim-fugitive'
	Plug 'dhruvasagar/vim-table-mode'
	Plug 'tpope/vim-commentary'

	call plug#end()
endif
" :PlugInstall


" https://github.com/dhruvasagar/vim-table-mode
let g:table_mode_corner='|'

nnoremap <leader>tm TableMode <cr>

nnoremap <C-/> :Commentary<CR>
vnoremap <C-/> :Commentary<CR>gv


nnoremap <silent> <leader>gb :Git blame<CR>

" Replay macro quicker
noremap Q @@
" Don't lose clipboard on exit
autocmd VimLeave,VimSuspend * call system("xsel -ib", getreg('+'))

" Normal mode: Yank inner word into register r and prep the substitute command
nnoremap <C-e> "ryiw:%s/<C-r>r//gc<Left><Left><Left>

" Visual mode: Yank selection into register r and prep the substitute command
vnoremap <C-e> "ry:%s/<C-r>r//gc<Left><Left><Left>



augroup GitMergeLook
    autocmd!
    " VimEnter fires after everything is loaded and the UI is ready
    autocmd VimEnter * if &diff | call SetMergeMode() | endif
augroup END

augroup GitMergeLook
    autocmd!
    " Trigger on VimEnter to ensure the UI is ready
    autocmd VimEnter * if &diff | call SetMergeMode() | endif
augroup END

function! GetGitInfo(type)
    " 'trim' is a built-in Vim function, faster than piping to 'tr'
    if a:type ==# 'local'
        return trim(system("git rev-parse --abbrev-ref HEAD 2>/dev/null"))
    elseif a:type ==# 'remote'
        let l:remote = trim(system("git name-rev --name-only MERGE_HEAD 2>/dev/null"))
        return (v:shell_error || l:remote ==# '') ? 'REMOTE' : l:remote
    endif
    return ''
endfunction

function! SetMergeMode()
    " --- PHASE 1: Always apply colors for any diff ---
    set termguicolors
    highlight DiffAdd    gui=none guifg=bg guibg=#5ff75f
    highlight DiffDelete gui=none guifg=bg guibg=#ff5f5f
    highlight DiffChange gui=none guifg=bg guibg=#5f5fff
    highlight DiffText   gui=none guifg=bg guibg=#1f1fbf
	highlight DiffTextAdd cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=#000000 guibg=#5fffaf
    highlight VertSplit  gui=none guifg=#444444 guibg=NONE

    " --- PHASE 2: Only apply labels if it's a 4-way Git Merge ---
    " filereadable is nearly instant compared to calling git
    if filereadable('.git/MERGE_HEAD') && winnr('$') >= 4
        let l:loc_br = GetGitInfo('local')
        let l:rem_br = GetGitInfo('remote')

        call setwinvar(1, '&statusline', '%#DiffAdd#  LOCAL  %* ' . l:loc_br)
        call setwinvar(2, '&statusline', '%#DiffText#  BASE  %*')
        call setwinvar(3, '&statusline', '%#DiffDelete#  REMOTE  %* ' . l:rem_br)
        call setwinvar(4, '&statusline', '%#Visual#  MERGED  %* %f %m')
        
        set laststatus=2
        
        " Jump to the MERGED window (bottom) automatically
        4wincmd w
    endif

    " --- PHASE 3: Clean up terminal artifacts ---
    " This wipes away the ^[[2;2R garbage from the screen
    silent! redraw!
endfunction


function! FindUsages(symbol)                                                                                           
  let cmd = 'rg -l ' . shellescape(expand('%:t:r')) . ' --type kotlin --type java | xargs rg ' . shellescape(a:symbol) .  ' -C 5'
  execute 'terminal bash -c "' . escape(cmd, '"') . '"'
endfunction

nnoremap <C-b> :call FindUsages(expand('<cword>'))<CR>
vnoremap <C-b> "ry:call FindUsages(@r)<CR>
" Leader Ctrl-B = navigate back (replaces Ctrl-O which is remapped in C++ buffers)
" If Ctrl-O is not remapped, you're not using a .vimrc that has your LSP setup
nnoremap <leader><C-B> <C-O>

