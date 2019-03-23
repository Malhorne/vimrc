" Disable vi specifics commands
set nocompatible

" VimPlug part {{{

" VimPlug settings {{{

" Path where VimPlug should install plugins
call plug#begin('~/.vim/vimplug')

" }}}

" VimPlug plugins {{{

" Plugin for Python fold
Plug 'tmhedberg/SimpylFold',         { 'for': 'python' }

" Plugin to indent Python
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Plugin to properly highlight Python
Plug 'vim-python/python-syntax',     { 'for': 'python' }

" Plugin to Lint code
Plug 'w0rp/ale'

" Completion plugin /!\ Needs to be manually built
Plug 'Valloric/YouCompleteMe'

" Great colorschemes
Plug 'morhetz/gruvbox'

" File Explorer Plugin
Plug 'scrooloose/nerdtree',          { 'on': 'NERDTreeToggle' }

" Bottom bar plugin
Plug 'itchyny/lightline.vim'

" Buffer tab extension to lightline
Plug 'mengelbrecht/lightline-bufferline'

" Plugin to highlight word occurences
Plug 'RRethy/vim-illuminate'

" Plugin for Latex
" TODO: Setup this plugin
" Plug 'lervag/vimtex'

" Plugin used for alignment
Plug 'tommcdo/vim-lion'

" Plugin for Python checking
Plug 'nvie/vim-flake8',              { 'for': 'python' }

" Plugin to ease commenting
Plug 'tpope/vim-commentary'

" Plugin to see letters for motions
Plug 'unblevable/quick-scope'

" Plugin to allow presentation in Vim
Plug 'tybenz/vimdeck'

" Plugin to highlight markdown
Plug 'tpope/vim-markdown'

" Plugin dependency for vimdeck, filetype syntax per region
Plug 'vim-scripts/SyntaxRange'

" Plugin to edit Firefox text area
" Plug 'pandysong/ghost-text.vim'

" All of your Plugins must be added before the following line
call plug#end()

" }}}

" Required for plugin indentation and filetype detection

" }}}

" Main configuration {{{

" Basic configuration {{{

" Basic configurations (automatically done by VimPlug but whatever)
filetype plugin indent on
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
" Scrolloff to never be in the last or first line
set scrolloff=5

" Maximum number of tabs to be safe
set tabpagemax=100
" Highlight the search results
set hlsearch
" Wildmenu for command completion
set wildmenu
" Show incomplete command
set showcmd

" Set the split vertical character
set fillchars=vert:\|

" This seems more natural to me
set splitright
" }}}

" Color scheme {{{

" Set syntax coloration (automatically done by VimPlug but whatever)
syntax on
" Set the number of color
set t_Co=256
" Set the background color
set background=dark
" Set the colorscheme
colorscheme gruvbox
" Set the terminal colors
set termguicolors
" Set the contrast
let g:gruvbox_contrast_dark = 'medium'

" }}}

" Terminal configuration {{{
tnoremap jk <C-\><C-N>
tnoremap kj <C-\><C-N>
let g:terminal_scrollback_buffer_size = -1

if has('nvim')
    augroup TermConfig
        autocmd!
        " Disable scrollback for terminal
        autocmd TermOpen * setlocal scrolloff=0
    augroup END
endif
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
nnoremap <C-N> :NERDTreeToggle<CR>
" Remap Ctrl-O to NERDTreeFind current folder
nnoremap <C-P> :NERDTreeFind<CR>

augroup NERDTree
    " Clean the group each time
    autocmd!
    " Close vim if the only tab remaining is NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" }}}

" SympylFold configuration {{{

" Preview docstring in fold text
let g:SimpylFold_docstring_preview = 1

" }}}

" YouCompleteMe configuration {{{

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_server_python_interpreter = "/usr/bin/python2"

" Clang static analyzer
let g:ycm_use_clangd = "Always"
let g:ycm_clangd_binary_path = "~/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clangd"

" }}}

" Lightline configuration {{{

" Always display the status bar
set laststatus=2
" Force to show the tabline
set showtabline=2
" Disable the basic Vim mode display
" It is already done by the plugin
set noshowmode
" Set the status line colorscheme
let g:lightline = {
            \'colorscheme': 'wombat',
            \}

" Lightline-Bufferline configuration
" let g:lightline#bufferline#show_number  = 1
" let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" }}}

" Vimtex configuration {{{

let g:vimtex_fold_enabled=1

" }}}

" ALE configuration {{{

" Customize the ALE message output format
let g:ale_echo_msg_error_str   = 'E'
let g:ale_echo_msg_warning_str = 'F'
" let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'

let g:ale_cpp_clangd_executable = "~/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clangd"
let g:ale_cpp_clang_executable = "~/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-16.04/bin/clang++"
let g:ale_cpp_clang_options = '-std=c++17 -Wall -stdlib=libc++'

" To navigate between the errors/warnings
" nnoremap <silent> <C-K> <Plug>(ale_previous_wrap)
" nnoremap <silent> <C-J> <Plug>(ale_next_wrap)

" }}}

" }}}

" File type configurations {{{

" Python file settings {{{

augroup filetype_python
    autocmd!
    " Make the code look pretty
    let g:python_highlight_all=1
    " Fold based on indentation
    autocmd FileType python set foldmethod=indent
    " Fold everything when opening a Python file
    autocmd FileType python setlocal foldlevel=0
    " Abbreviation to import pdb
    iabbrev pdb import pdb; pdb.set_trace()
augroup END

" }}}

" Vimscript file settings {{{

augroup filetype_vim
    autocmd!
    " For Vim files we use marker foldmethod
    autocmd FileType vim setlocal foldmethod=marker
    " Fold everything when opening a Vim file
    autocmd FileType vim setlocal foldlevel=0
augroup END

" }}}

" Latex file settings {{{

augroup filetype_latex
    " Clean the group each time
    autocmd!
    " When editing Latex file I prefer a shiftwidth of 2
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

" Mds file settins {{{
let g:MIDAS_UseFolding = 1
let g:MIDAS_UseCompletion = 0
" }}}

" }}}

" Custom mappings {{{

" Enable folding with the spacebar
nnoremap <space> za

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
nnoremap Q <nop>
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

" Mapping to open a split with exploration
nnoremap <leader>S :Sexplore<CR>
nnoremap <leader>V :Vexplore<CR>

" To stop highlighting with Enter
nnoremap <CR> :noh<CR><CR>

" Test for entire document
" This is supposed to be a motion concerning the inner document (understand
" all the document)
onoremap <silent> id :<C-U>normal! ggVG<CR>

" Use Tab and Shift-Tab to move between buffers
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" Little test for long lines
nnoremap j gj
nnoremap k gk

" Like <C-r><C-> for the current line
cnoremap <C-R><C-L> <C-R>=getline('.')<CR>

" Remap <C-c> to remove the buffer from the list without closing the split
nnoremap <C-C> :bp<CR>:bd #<CR>

" Remap <C-W> to open a terminal in a new buffer
if has('nvim')
    nnoremap <C-W>t :tabe term://zsh<CR>
endif

" }}}

" Grep custom functions {{{

" Mapping to grep -R current WORD under cursor
nnoremap <leader>G :silent execute "grep! -R -I " . shellescape(expand("<cWORD>")) . " ."<cr>:redr!<cr>:copen 10<cr>

" Operator to grep -R in visual and normal mode
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    " Save the value of the register prior to the function execution
    let l:save_unnamed_register = @@

    " If it is a visual mode (not block nor line visual)
    if a:type ==# 'v'
        normal! `<v`>y
    " If it is a normal motion
    elseif a:type ==# 'char'
        normal! `[v`]y
    " Otherwise we do not treat it
    else
        return
    endif

    " Execute the grep -R -I with the escape of the considered string
    silent execute "grep! -R -I " . shellescape(@@) . " ."
    " To prevent the silent bug
    redraw!
    " Open the quickfix window
    copen 12

    " Restore the register
    let @@ = l:save_unnamed_register
endfunction


" }}}

" SpellCheck custom function {{{

" For the ToggleSpell function
let g:spellOn = 0

" Used to toggle spellchecking and highlight ill spelled words
function! s:ToggleSpell()
  if g:spellOn ==# 0
	setlocal spell
	highlight SpellBad ctermbg=red guibg=red
	let g:spellOn = 1
  else
	setlocal nospell
	let g:spellOn = 0
  endif
endfunction

" Map F6 to call this previous functions
nnoremap <F6> :call <SID>ToggleSpell()<CR>

" }}}

" To prevent a bug with system clipboard on my computer do not mind
set t_BE=
