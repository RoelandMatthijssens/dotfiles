let mapleader = ","

set nocompatible
filetype off

"filetype off Vundle setup
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'rking/ag.vim'
Plugin 'powerline/fonts'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tlib_vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-unimpaired'
Plugin 'fweep/vim-zsh-path-completion'
Plugin 'kshenoy/vim-signature'
Plugin 'tpope/vim-commentary'
Plugin 'christoomey/vim-sort-motion'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-indent'
Plugin 'bps/vim-textobj-python'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'rust-lang/rust.vim'

call vundle#end()
filetype plugin indent on

set ttyfast
set visualbell

" fold control
set foldmethod=indent
set foldnestmax=1
set foldlevel=99
nnoremap <space> za

set ignorecase
set smartcase
set wildmode=longest,list,full
set updatetime=250
" execute pathogen plugin loader
" execute pathogen#infect()

" enable syntax highlighting
syntax enable
filetype plugin on
set synmaxcol=121

" show line numbers
set relativenumber
set number

set list
set listchars=tab:▸\ ,extends:¬,precedes:‽

set textwidth=119
" indent when moving to the next line while writing code
set autoindent

" Tab control
set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround

" show a visual line under the cursor's current line
set cursorline

" spellchecker
" setlocal spell spelllang=en_us
nnoremap <leader>spell :setlocal spell! spelllang=en_us<CR>
hi clear SpellBad
hi SpellBad cterm=underline

set clipboard=unnamed

" show the matching part of the pair for [] {} and ()
set showmatch

" keep more context when scrolling off the end of a buffer
set scrolloff=10

" search
set incsearch
set hlsearch
" move search result to middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz

set scroll=10
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <C-S-y> "+y
vnoremap <C-S-y> "+y

"don't open the first occurence when searching with Ag
ca Ag Ag! --ignore='*test*' <cword>
ca Agt Ag! -G test <cword>
"use Ag to find usages
nnoremap <leader>u *:AgFromSearch!<cr>

"common command typos
command W w
nnoremap W <nop>
command Q q
nnoremap Q <nop>

" If a file is changed outside of vim, automatically reload it without asking
set autoread

" enable all Python syntax highlighting features
let python_highlight_all = 1

" automatically remove trailing whitespaces on save
match ErrorMsg '\s\+$'
autocmd BufWritePre * %s/\s\+$//e

" remaps
inoremap <C-Space> <C-p>
nnoremap <leader>l :FZF<cr>

"faster scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" repeat selection after indent
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" slugify selected string
vnoremap <leader>s <ESC>:s/\%V /_/g<CR>
"
" Move around splits with <c-hjkl>
noremap <silent> <C-h> :call functions#WinMove('h')<cr>
noremap <silent> <C-j> :call functions#WinMove('j')<cr>
noremap <silent> <C-k> :call functions#WinMove('k')<cr>
noremap <silent> <C-l> :call functions#WinMove('l')<cr>

" python breakpoints
map <silent> <leader>b oimport pdb; pdb.set_trace()<esc>
map <silent> <leader>B Oimport pdb; pdb.set_trace()<esc>

map <leader>, :w<CR>


" NERDtree config
let NERDTreeIgnore = ['\.pyc$']
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" jedi config
let g:jedi#use_splits_not_buffers = "right"
" disable preview window during autocomplete
autocmd FileType python setlocal completeopt-=preview

set laststatus=2
set t_Co=256

" airline config
let g:airline_powerline_fonts=1
let g:airline_detect_spell=1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#show_buffers = 0 " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#branch#displayed_head_limit = 10

let g:solarized_diffmode="high"

let g:flake8_cmd="/usr/bin/python3-flake8"
colorscheme enermis


" get syntax group of word under cursor
" usefull for adding custom colors to the color theme and you want to know what the syntax group is called
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Open line in github
nnoremap <leader>git :!echo `git url`/blob/`git rev-parse --abbrev-ref HEAD`/%\#L<C-R>=line('.')<CR> \| xargs xdg-open<CR><CR>
" reformat xml
nnoremap <leader>xml :call functions#DoPrettyXml()<CR>
