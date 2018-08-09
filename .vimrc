" Disable vi specifics commands
set nocompatible
" For Vundle to work correctly we need to disable it
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=/home/matcha02/local_work/.vim
set rtp+=~/local_work/.vim/bundle/Vundle.vim

" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/local_work/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" Plugin for Pythong fold
Plugin 'tmhedberg/SimpylFold'
" Plugin to indent Python
Plugin 'vim-scripts/indentpython.vim'
" Completion plugin /!\ Needs to be manually built
Plugin 'Valloric/YouCompleteMe'
" Plugin to do syntax analysis
Plugin 'scrooloose/syntastic'
" Great colorscheme
Plugin 'morhetz/gruvbox'
" File Explorer Plugin
Plugin 'scrooloose/nerdtree'
" Bottom bar plugin
Plugin 'vim-airline/vim-airline'
" Plugin to highlight word occurences
Plugin 'RRethy/vim-illuminate'
" All of your Plugins must be added before the following line
call vundle#end()

" Required for plugin indentation and filetype detection
filetype plugin indent on

" Enable folding
set foldmethod=indent
set foldlevel=99
" Configuration of SympylFold
let g:SimpylFold_docstring_preview=1

" For YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Ignore temp files with NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" Enable folding with the spacebar
nnoremap <space> za

" Number of spaces that a Tab produces
set tabstop=4
" Number of spaces that a Tab counts for while performing editing operations
set softtabstop=4
" To use backspace anytime
set backspace=2
" Number of spaces used for (auto)indent
set shiftwidth=4
" To keep the indentation when inserting new line
set autoindent
" To expand tabs into spaces
set expandtab
" Because who use Windows/MacOS ;)
set fileformat=unix
" Make the code look pretty
let python_highlight_all=1
syntax on

" When editing latex file I prefer a shiftwidth of 2
au BufNewFile,BufRead *.tex set sw=2

" Personal use: I want sh syntax for file with .pkg extension
au BufNewFile,BufRead *.pkg set syntax=sh

" UTF-8 support
set encoding=utf-8

" Color scheme
set t_Co=256
set background=dark
colorscheme gruvbox

" Line numbering
set nu

" System clipboard if your vim is compiled with it
" To know it type :version inside vim and look for +clipboard
set clipboard=unnamed

" Replacing the arrow icons in NERDTree
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

" Close vim if the only tab remaining is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Airline configuration
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
let g:airline_section_c=''

" Remap Ctrl-N to NERDTreeToggle
nnoremap <C-n> :NERDTreeToogle<CR>
" Remap Ctrl-P to NERDTreeFind current folder
nnoremap <C-p> :NERDTreeFind<CR>

" Set incremental search
set incsearch
" Allow the usage of mouse in every mode every time
set mouse=a

" Set the tex_flavor to latex. Used for an internal plugin not described in this file
let g:tex_flavor='latex'

" Maximum number of tabs to be safe
set tabpagemax=100
" Highlight the search results
set hlsearch

" Remap default Enter to stop highlighting
nnoremap <CR> :noh<CR><CR>
" Remap z/ to search inside the current screen
nnoremap <silent> z/ :set scrolloff=0<CR>VHoL<Esc>:set scrolloff=1<CR>``/\%V
" Map F10 to print which is the syntax group under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Let's try this it could be funny
" Mapping of jk and kj to Esc to prevent finger hell
inoremap jk <C-[>
inoremap kj <C-[>
" To learn how to use the previous shortcuts

" I've got an Azerty keyboard and I am way too lazy to switch
" So I made a key with + and - to navigate lines
nnoremap ) +
nnoremap ° -

" To move between the splits without having too much trouble
nnoremap <C-J> <C-W><C-J>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Leader key to Q (because ex mode is not really useful)
let mapleader="Q"
" Qev open a split to edit the vimrc
" You can use $MYVIMRC instead of the hard path
nnoremap <leader>ev :vsplit ~/local_work/.vimrc<CR>
" Qsv to source the vimrc
nnoremap <leader>sv :so ~/local_work/.vimrc<CR>
" Qu to lower case the current word
nnoremap <leader>u viwu
" QU to upper case the current word
nnoremap <leader>U viwU
" Q" to surround the current word with double quotes
nnoremap <leader>" viw<Esc>a"<Esc>bi"<Esc>lel
" Q' to surround the current word with simple quotes
nnoremap <leader>' viw<Esc>a'<Esc>bi'<Esc>lel

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

" Map F6 to call this previous functions
map <F6> :call ToggleSpell()<CR>

" Highlight the extra whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red

" Define the extra whitespace as the one at the end of line for no reason
match ExtraWhitespace /\s\+$/

" To prevent a bug with system clipboard on my computer do not mind
set t_BE=
