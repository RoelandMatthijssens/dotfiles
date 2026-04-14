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
" Plugin 'SirVer/ultisnips'
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
Plugin 'fatih/vim-go', {'do': ':GoInstallBinaries'}

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
set background=dark
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
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *Nzzzv

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
vmap > >gv
vmap < <gv

" slugify selected string
vnoremap <leader>s <ESC>:s/\%V /_/g<CR>
"
" Move around splits with <c-hjkl>
noremap <silent> <C-h> :call functions#WinMove('h')<cr>
noremap <silent> <C-j> :call functions#WinMove('j')<cr>
noremap <silent> <C-k> :call functions#WinMove('k')<cr>
noremap <silent> <C-l> :call functions#WinMove('l')<cr>

map <leader>, :w<CR>

" Test using vim-test
noremap tt :TestNearest<CR>
noremap rt :TestFile<CR>
noremap rat :TestSuite<CR>
let test#strategy = "vimux"


" Vimux config
let g:VimuxUseNearest = 1
let g:VimuxResetSequence = "q C-c C-u C-l"

nnoremap rr :call VimuxRunCommand("make run")<CR>
nnoremap rl :call VimuxRunCommand("make lint")<CR>

" NERDtree config
let NERDTreeIgnore = ['\.pyc$', 'node_modules']
silent! map <F3> :NERDTreeFind<CR>

" Remap F1 to escape because of fat fingers
imap <F1> <esc>
nmap <F1> <esc>
map <F1> <esc>

" ALE config
let g:ale_linters = {}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier'],
\   'typescript': ['eslint'],
\   'json': ['prettier'],
\   'ruby': ['rubocop'],
\   'python': ['autopep8'],
\   'yaml': ['yamlfix'],
\}

let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_sign_error = '>'
let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '-'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
let g:ale_hover_to_floating_preview = 1
let g:ale_set_balloons = 1
let g:ale_ruby_rubocop_executable='bundle'

"*****************************************************************************
"================================== go =======================================
"*****************************************************************************
" vim-go
" run :GoBuild or :GoTestCompile based on the go file
" vim-test
"" Tabs. May be overridden by autocmd rules
" let test#go#gotest#options = '-p 8'

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
" let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1


augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go

  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au FileType go nmap gf <Plug>(go-def)
  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <C-g> :GoDecls<cr>
  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

augroup END

" ale

function! WslCuddleFixer(buffer) abort
  let l:filename = expand('%:p')
    return {
          \  'command': 'wsl --all --fix ' . l:filename,
          \  'stdin': 0,
          \ }
endfunction
call ale#fix#registry#Add('wsl-cuddle', 'WslCuddleFixer', ['go'], 'wsl cuddle fixer for go')

" Add 'golangci-lint' as a fixer for Go
:call extend(g:ale_linters, {"go": ['golint', 'go vet', 'golangci-lint']})
:call extend(g:ale_fixers,  {'go': ['gofmt', 'goimports', 'gopls', 'golines', 'gofumpt', 'wsl-cuddle']})

let g:vrc_variables = {"ALM_RBAC_JWT":system('cat .alm_rbac.jwt')}

"*****************************************************************************
"*****************************************************************************

"indentation management
set expandtab softtabstop=2 tabstop=2 shiftwidth=2 shiftround
autocmd FileType php setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 shiftround
autocmd FileType python setlocal expandtab softtabstop=4 tabstop=4 shiftwidth=4 shiftround
autocmd FileType typescript setlocal expandtab softtabstop=2 tabstop=2 shiftwidth=2 shiftround
autocmd FileType javascript setlocal softtabstop=2 tabstop=2 shiftwidth=2 shiftround
autocmd FileType go setlocal expandtab softtabstop=2 tabstop=2 shiftwidth=2 shiftround

set laststatus=2
set t_Co=256


" autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %

"
" " airline config
" vim-airline
let g:airline_detect_spell=1
let g:airline_detect_paste=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#tab_min_count = 2 " only show tabline if tabs are being used (more than 1 tab open)
let g:airline#extensions#tabline#show_buffers = 0 " do not show open buffers in tabline
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#ale#enabled = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

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
" Tabularize json fields in Go
vnoremap <leader>tj :s/ \+/ /g<CR>:Tabularize / /l0<CR>:noh<CR>:w<CR>

" Reformat entire file
nmap <F7> gg=G<C-o><C-o>

colorscheme afterglow
" colorscheme oceanic_material
" colorscheme seoul256

" use new sniptmate parser
let g:snipMate = {'snippet_version': 1}
" let g:UltiSnipsExpandTrigger="<tab>"

" Rest client config
au BufNewFile,BufRead,BufReadPost *.http set syntax=rest filetype=rest
let g:vrc_trigger = '<C-b>'
let b:vrc_response_default_content_type = 'application/json'
let g:vrc_curl_opts = {
\  '-L': '',
\  '-i': '',
\  '-s': '',
\  '-k': '',
\}

let g:asyncrun_open = 12

" CSV
let g:csv_arrange_align = 'l*'
let g:csv_autocmd_arrange = 1

set mouse=
