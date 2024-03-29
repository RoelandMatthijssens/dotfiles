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
Plugin 'tomtom/tlib_vim'
Plugin 'vim-airline/vim-airline'
Plugin 'rhysd/committia.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/gem-ctags'
Plugin 'universal-ctags/ctags'
Plugin 'airblade/vim-gitgutter'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'kshenoy/vim-signature'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'dense-analysis/ale'
" Plugin 'leafgarland/typescript-vim'
" Plugin 'peitalin/vim-jsx-typescript'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'chiedo/vim-case-convert'
" Plugin 'pangloss/vim-javascript'
" Plugin 'mxw/vim-jsx'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'diepm/vim-rest-console'
Plugin 'chrisbra/csv.vim'
Plugin 'djoshea/vim-autoread'
Plugin 'ruanyl/vim-gh-line'
Plugin 'nvim-lua/plenary.nvim'
Plugin 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plugin 'chrisbra/Colorizer'
Plugin 'vim-test/vim-test'
Plugin 'sheerun/vim-polyglot'

Plugin 'preservim/vimux'

call vundle#end()
filetype plugin indent on

set ttyfast
" set noerrorbells
" set novisualbell
set noeb vb t_vb=

" fold control
set foldmethod=indent
set foldlevelstart=20
nnoremap <space> za

set ignorecase
set smartcase
set wildmode=longest,list,full
set updatetime=1000

" enable syntax highlighting
syntax enable
filetype plugin on

set number

set nolist
" set listchars=tab:▸\ ,extends:¬,precedes:‽

set textwidth=119
" indent when moving to the next line while writing code
set autoindent

" spellchecker
" setlocal spell spelllang=en_us
nnoremap <leader>spell :setlocal spell! spelllang=en_us<CR>
" hi clear SpellBad
" hi SpellBad cterm=underline

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
nnoremap * *Nzz

set scroll=10
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <C-S-y> "+y
vnoremap <C-S-y> "+y

"don't open the first occurence when searching with Ag
ca Ag Ag!
ca Agt Ag! -G test
command! -bang -nargs=* Find call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)
"use Ag to find usages
nnoremap <leader>u *:AgFromSearch!<cr>

"common command typos
command W w
nnoremap W <nop>
command Q q
nnoremap Q <nop>

" If a file is changed outside of vim, automatically reload it without asking
set autoread

" automatically remove trailing whitespaces on save
match ErrorMsg '\s\+$'
autocmd BufWritePre * %s/\s\+$//e

nnoremap <leader>l :FZF<cr>
nnoremap <leader>k :Find<cr>

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

map <leader>, :w<CR>

" Test without vim-test
" noremap tt :execute "AsyncRun -mode=term -pos=tmux rails test " . expand("%") . ":" . line(".")<cr>
" noremap rt :AsyncRun -mode=term -pos=tmux rails test %<cr>
" noremap rat :AsyncRun -mode=term -pos=tmux rails test<cr>

" Test using vim-test
noremap tt :TestNearest<CR>
noremap rt :TestFile<CR>
noremap rat :TestSuite<CR>
let test#strategy = "vimux"


" NERDtree config
let NERDTreeIgnore = ['\.pyc$', 'node_modules']
silent! map <F3> :NERDTreeFind<CR>

" Remap F1 to escape because of fat fingers
imap <F1> <esc>
nmap <F1> <esc>
map <F1> <esc>

"indentation management
set expandtab softtabstop=2 tabstop=2 shiftwidth=2 shiftround
autocmd FileType php setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 shiftround
autocmd FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 shiftround
autocmd FileType go setlocal tabstop=4 shiftwidth=4 shiftround
autocmd FileType typescript setlocal expandtab softtabstop=2 tabstop=2 shiftwidth=2 shiftround
autocmd FileType javascript setlocal softtabstop=2 tabstop=2 shiftwidth=2 shiftround

set laststatus=2
set t_Co=256

" ALE config
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['eslint'],
\   'json': ['prettier'],
\   'ruby': ['rubocop'],
\   'python': ['autopep8'],
\}
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_set_balloons = 1

" autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %

"
" airline config
let g:airline_powerline_fonts=1
let g:airline_detect_spell=1
let g:airline_detect_paste=1
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#show_buffers = 0 " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#ale#enabled = 1

let g:solarized_diffmode="high"

" git fugitive config
" open file history
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 1
let g:gh_line_map = '<leader>git'
nnoremap gh :0Gllog<CR>
nnoremap gn :lnext<CR>
nnoremap gp :lprev<CR>

" load entire subtree in path for filefinding using gf
set path+=./**

" get syntax group of word under cursor
" usefull for adding custom colors to the color theme and you want to know what the syntax group is called
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" reformat xml
nnoremap <leader>xml :call functions#DoPrettyXml()<CR>
" Tabularize
nnoremap <leader>tab :Tabularize /\|<CR>

" Reformat entire file
nmap <F7> gg=G<C-o><C-o>

colorscheme BusyBee_modified

" use new sniptmate parser
let g:snipMate = {'snippet_version': 1}

" Rest client config
au BufNewFile,BufRead,BufReadPost *.http set syntax=rest filetype=rest
let g:vrc_trigger = '<C-b>'
let b:vrc_response_default_content_type = 'application/json'
let g:vrc_curl_opts = {
\  '-L': '',
\  '-i': '',
\  '-s': '',
\  '--ipv4': '',
\  '-k': '',
\}

let g:asyncrun_open = 12

set mouse=
