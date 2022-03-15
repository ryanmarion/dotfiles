"=
"Plugins"
"

call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'tomasiser/vim-code-dark'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
call plug#end()

"=
"Customizations"
"

syntax enable
colorscheme nord
let g:mapleader = ","

"CoC extensions"
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-prettier']

"=
"Settings"
"

set path+=**
set shell=zsh
set dir=/tmp
set smartcase
set noerrorbells
set nowrap
set autoread
set showmode
set history=1000
set term=screen-256color
let NERDTreeShowHidden=1
set cursorline
set number 

"Airline Config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = ['branch', 'tabline', 'hunks', 'coc']

"=
"Key Maps"
"=

"turn off recording
map q <Nop>

"nerd tree
nnoremap <leader>nt :call OpenOrFocusNERDTree()<CR>
nnoremap <leader>ct :NERDTreeClose<CR>

"search for files/string matches
map <C-p> :GFiles<CR>
map <C-o> :Ag<CR>

"coc, format code
nnoremap <leader>cf :Format<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" auto pair these chars
"ino " ""<left>
"ino ' ''<left>
"ino ( ()<left>
"ino [ []<left>
"ino { {}<left>
"ino {<CR> {<CR>}<ESC>O

"=
"Commands"
"=

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

command! ProjectFiles execute 'Files' s:find_git_root()
command! -nargs=0 Format :call CocActionAsync('format')

"=
"Functions"
"=

function! OpenOrFocusNERDTree()
  if exists('t:NERDTreeBufName')
    NERDTreeFocus
  else
    NERDTreeToggle
  endif
endfunction

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
