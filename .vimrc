" set the runtime path to include Vundle and initialize
set shell=bash
set rtp+=~/.vim/bundle/Vundle.vim

set nocompatible              " required
set number
set clipboard=unnamed
set encoding=utf-8
syntax enable

filetype plugin indent on    " required
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=199 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" Plug plugins
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Initialize plugin system
call plug#end()

" run pathogen
execute pathogen#infect()

call vundle#begin()
" ===== Vundle Plugins ======
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kshenoy/vim-signature'
Plugin 'pangloss/vim-javascript'
Plugin 'flazz/vim-colorschemes'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" ===== END OF Vundle Plugins ======
call vundle#end()            " required


highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" totoro settings
" appearance settings
set background=dark
let python_highlight_all=1
let g:solarized_termcolors=16
colorscheme Monokai

let mapleader=","
" ============ LEADER mappings ===============
" fzf shortcuts
nnoremap <LEADER>f :Files<CR>
nnoremap <LEADER>h :History<CR>
nnoremap <LEADER>l :Lines<CR>
nnoremap <LEADER>bl :BLines<CR>
nnoremap <LEADER>w :Windows<CR>
nnoremap <LEADER>t :Tags<CR>
nnoremap <LEADER>bt :BTags<CR>
nnoremap <LEADER>buf :Buffers<CR>
nnoremap <LEADER>ag :Ag<CR>
nnoremap <LEADER>rs :source ~/.vimrc<CR>
" save stuff
" TODO add white space stripping
inoremap <LEADER>s <ESC>:update<CR>
nnoremap <LEADER>s :update<CR>
" ============ END OF LEADER mappings ===============

nnoremap fjs :%! python -m json.tool<CR>
" window shortcuts
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
" experimental
nnoremap ; :

" escape stuff
inoremap jk <ESC>

" remove trailing whitespace when save
autocmd BufWritePre * %s/\s\+$//e

" Enable folding
set foldmethod=indent
set foldnestmax=2
set foldlevel=99
set foldlevelstart=0
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

" w0rp/ale settings
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" Enable folding with the spacebar
nnoremap <space> za

autocmd VimEnter * silent !echo -ne "\033]1337;SetKeyLabel=F7=Flake8\a"
autocmd VimEnter * silent !echo -ne "\033]1337;SetKeyLabel=F1=Help\a"
autocmd VimEnter * silent !echo -ne "\033]1337;SetKeyLabel=F1=NERDTree\a"
autocmd VimLeave * silent !echo -ne "\033]1337;PopKeyLabels\a"
map <silent> <F2> :NERDTreeToggle<CR>

" Debug shortcuts
map <silent> <leader>pdb oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>nose ofrom nose.tools import set_trace; set_trace()<esc>
map <silent> <leader>debugger odebugger // eslint-disable-line<esc>

" Make backspace work
set backspace=indent,eol,start

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" indicate this is the window to swap to - max swap
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

" nmap <silent> <leader>q :call MarkWindowSwap()<CR>
" nmap <silent> <leader>w :call DoWindowSwap()<CR>

" ignore pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
