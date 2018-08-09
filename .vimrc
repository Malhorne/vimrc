set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=/home/matcha02/local_work/.vim
set rtp+=~/local_work/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/local_work/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'RRethy/vim-illuminate'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable folding
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1

" For YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
" let g:ycm_server_python_interpreter="/arm/tools/python/python/2.7.8/rhe7-x86_64/bin/python"
" let g:ycm_server_python_interpreter="/usr/bin/python"
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Ignore /pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Enable folding with the spacebar
nnoremap <space> za

set tabstop=4
set softtabstop=4
set backspace=2
set shiftwidth=4
" Indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" Indentation
au BufNewFile,BufRead *.c, *.cpp, *.h, *.hpp, *.vim
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set fileformat=unix |

au BufNewFile,BufRead *.tex set sw=2

au BufNewFile,BufRead *.pkg set syntax=sh

" UTF-8 support
set encoding=utf-8

" Make the code look pretty
let python_highlight_all=1
syntax on

" Color scheme
set t_Co=256
set background=dark
colorscheme gruvbox
"call togglebg#map("<F5>")

" Line numbering
set nu

" System clipboard
set clipboard=unnamed

" Open a NERDTree upon each start of vim
" autocmd vimenter * NERDTree
" autocmd vimenter * wincmd w

" Replacing the arrow icons
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

" Close vim if the only tab remaining is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline things
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
let g:airline_section_c=''

nnoremap <C-n> :NERDTreeToogle<CR>
nnoremap <C-p> :NERDTreeFind<CR>
set incsearch
set mouse=a

let g:tex_flavor='latex'

set tabpagemax=100
set hlsearch

nnoremap <CR> :noh<CR><CR>
nnoremap <silent> z/ :set scrolloff=0<CR>VHoL<Esc>:set scrolloff=1<CR>``/\%V
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Let's try this it could be funny
inoremap jk <C-[>
inoremap kj <C-[>
nnoremap ) +
nnoremap ° -
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Leader key
let mapleader="Q"
nnoremap <leader>ev :vsplit ~/local_work/.vimrc<CR>
nnoremap <leader>sv :so ~/local_work/.vimrc<CR>

" For the ToggleSpell function
let g:spellOn=0

" Used to toggle spellchecking and highlight ill spelled words
function! ToggleSpell()
  if g:spellOn == 0
	setlocal spell
	highlight SpellBad ctermbg=red guibg=red
	let g:spellOn=1
  else
	setlocal nospell
	let g:spellOn=0
  endif
endfunction

map <F6> :call ToggleSpell()<CR>

highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/

set t_BE=
