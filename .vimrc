" Disable vi specifics commands
set nocompatible

" Vundle part {{{

" For Vundle to work correctly we need to disable it
filetype off

" Vundle settings {{{
" set the runtime path to include Vundle and initialize
set rtp+=/home/malhorne/.vim
set rtp+=~/.vim/bundle/Vundle.vim

" alternatively, pass a path where Vundle should install plugins
call vundle#begin('~/.vim/bundle')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" }}}

" Vundle plugins {{{
" Plugin for Python fold
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
" Plugin for Latex
" TODO: Setup this plugin
Plugin 'lervag/vimtex'
" All of your Plugins must be added before the following line
call vundle#end()
" }}}

" Required for plugin indentation and filetype detection
filetype plugin indent on

" }}}

" Main configuration {{{

" Basic configuration {{{

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
" UTF-8 support
set encoding=utf-8
" Line numbering
set number
" Set incremental search
set incsearch
" Allow the usage of mouse in every mode every time
set mouse=a

" Maximum number of tabs to be safe
set tabpagemax=100
" Highlight the search results
set hlsearch

" }}}

" Color scheme {{{

" Set syntax coloration
syntax on
" Set the number of color
set t_Co=256
" Set the background color
set background=dark
" Set the colorscheme
colorscheme gruvbox

" }}}

" }}}

" Plugin configurations {{{

" NERDTree configuration {{{

" Ignore temp files with NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']
" Replacing the arrow icons in NERDTree
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"
" Remap Ctrl-N to NERDTreeToggle
nnoremap <C-n> :NERDTreeToggle<CR>
" Remap Ctrl-P to NERDTreeFind current folder
nnoremap <C-p> :NERDTreeFind<CR>
augroup NERDTree
    " Clean the group each time
    autocmd!
    " Close vim if the only tab remaining is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" }}}

" SympylFold configuration {{{

" Configuration of SympylFold
let g:SimpylFold_docstring_preview=1

" }}}

" YouCompleteMe configuration {{{

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_server_python_interpreter = "/usr/bin/python2"

" }}}

" Airline configuration {{{

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme='dark'
let g:airline_section_c=''

" }}}

" Vimtex configuration {{{

let g:vimtex_fold_enabled=1

" }}}

" }}}

" File type configurations {{{
" Python file settings {{{

augroup filetype_python
    autocmd!
    " Make the code look pretty
    autocmd FileType python let python_highlight_all=1
    " Fold based on indentation
    autocmd FileType python set foldmethod=indent
augroup END

" }}}

" Vimscript file settings {{{

augroup filetype_vim
    autocmd!
    " For vim files we use marker foldmethod
    autocmd FileType vim setlocal foldmethod=marker
    " Fold everything when opening a vim file
    autocmd FileType vim setlocal foldlevel=0
augroup END

" }}}

" Latex file settings {{{

augroup filetype_latex
    " Clean the group each time
    autocmd!
    " When editing latex file I prefer a shiftwidth of 2
    autocmd BufNewFile,BufRead *.tex set sw=2
augroup END

" }}}

" Pkg file settings {{{

augroup filetype_pkg
    autocmd!
    " Personal use: I want sh syntax for file with .pkg extension
    autocmd BufNewFile,BufRead *.pkg set syntax=sh
augroup END

" }}}

" }}}

" Custom mappings {{{

" Enable folding with the spacebar
nnoremap <space> za

" Remap default Enter to stop highlighting
nnoremap <CR> :noh<CR><CR>

" Remap z/ to search inside the current screen
nnoremap <silent> z/ :set scrolloff=0<CR>VHoL<Esc>:set scrolloff=1<CR>``/\%V

" Map F10 to print which is the syntax group under the cursor
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Mapping of jk and kj to Esc to prevent finger hell
inoremap jk <C-[>
inoremap kj <C-[>

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
nnoremap <leader>ev :vsplit ~/.vimrc<CR>

" Qsv to source the vimrc
nnoremap <leader>sv :so ~/.vimrc<CR>

" Qu to lower case the current word
nnoremap <leader>u viwu

" QU to upper case the current word
nnoremap <leader>U viwU

" Q" to surround the current word with double quotes
nnoremap <leader>" viw<Esc>a"<Esc>bi"<Esc>lel

" Q' to surround the current word with simple quotes
nnoremap <leader>' viw<Esc>a'<Esc>bi'<Esc>lel

" Mapping to add a semi-colon at the end of a line
nnoremap <leader>; mWA;<Esc>`W

" Mapping to grep -R current word
nnoremap <leader>g :silent execute "grep! -R -I " . shellescape(expand("<cWORD>")) . " ."<cr>:redr!<cr>:copen 12<cr>
" }}}

" SpellCheck custom function {{{

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
nnoremap <F6> :call ToggleSpell()<CR>

" }}}

" Custom highlights {{{

" Highlight the extra whitespace in red
highlight ExtraWhitespace ctermbg=red guibg=red

" Define the extra whitespace as the one at the end of line for no reason
match ExtraWhitespace /\s\+$/

" }}}

" To prevent a bug with system clipboard on my computer do not mind
" Commenting because it seems to be fixed in another way
" Keeping it there just in case bad things happen
set t_BE=
