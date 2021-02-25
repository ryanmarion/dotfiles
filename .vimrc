" This is a suggested vimrc managed by puppet. Copy it into ~/.vimrc as a starting point
" Then execute: vim +PlugInstall +qall

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'jlanzarotta/bufexplorer'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'bitc/vim-bad-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'crusoexia/vim-monokai'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'markabe/vim-jira-open'
call plug#end()

"==
"  rzm customs
"==
syntax enable
colorscheme codedark


"==
" Plugin Settings
"==

let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }
let g:syntastic_check_on_open = 0
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }


"==
" Settings
"==
set path+=**
set shell=bash
set dir=/tmp
set smartcase
set noerrorbells
set expandtab
set nowrap
set autoread
set showmode
set number
set nu
set tabstop=2
set sw=2
set history=1000
set wildchar=<Tab> wildmenu wildmode=full
"set foldmethod=manual
"set foldcolumn=2
let mapleader = ","
let g:mapleader = ","
set laststatus=2
set term=screen-256color

let g:jira_browse_url = 'https://jira.kount.com/browse/'

"==
" Keys Maps
"==
nnoremap <leader>nt :call OpenOrFocusNERDTree()<CR>
nnoremap <leader>ct :NERDTreeClose<CR>

nnoremap <leader>ss :setlocal spell!<cr>

nnoremap <Leader>a yiw:Ack! <C-r>"<CR>

nnoremap <Leader>cf :let @" = expand("%")<cr>

nnoremap <space> i <Esc>

nnoremap < <<
nnoremap > >>
vnoremap < <gv
vnoremap > >gv

"nnoremap  ;  :
"nnoremap  :  ;

nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>
nnoremap tn :tabnew<CR>
nnoremap tc :tabclose<CR>

inoremap jk <Esc>

nnoremap fh :bprev<CR>
nnoremap fl :bnext<CR>

map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

nnoremap <leader>ln :lne<CR>
nnoremap <leader>lp :lp<CR>

"execute buffer
nnoremap <leader>2 :@"<CR>
vnoremap <leader>2 y:@"<CR>

inoremap <silent> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>

nnoremap <leader>cdb :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>cdp :call SetProjectRoot()<CR>

vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

nnoremap <C-]> g<C-]>

nnoremap <leader>oj :<C-U>call JiraOpen()<CR><CR>

nnoremap <leader>cf :!echo -n % \| pbcopy<CR><CR>
nnoremap <leader>yf :let @"=expand('%')<CR>


"==
" Commands
"==
command! W w !sudo tee % > /dev/null

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"==
" Functions
"==
function! OpenOrFocusNERDTree()
  if exists('t:NERDTreeBufName')
    NERDTreeFocus
  else
    NERDTreeToggle
  endif
endfunction

" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction

" set working directory to git project root
" or directory of current file if not git project
function! SetProjectRoot()
  " default to the current file's directory
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  " See if the command output starts with 'fatal' (if it does, not in a git repo)
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  " if git project, change local directory to git project root
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction

"==
" Auto commands
"==
augroup fileType
  autocmd!
  au FileType go nmap <buffer> <leader>t <Plug>(go-test)
  au FileType go nmap <leader>bl <Plug>(go-build)
  au FileType markdown setlocal ts=4 sw=4
  "au FileType php setlocal tabstop=4 sw=4
augroup END

"==
" MEMEX
"==
noremap nj :find \<<C-r><C-w>\>*<CR>

