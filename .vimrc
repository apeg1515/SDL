let g:ycm_path_to_python_interpretor ="/usr/local/bin/python"
set viminfo=%,<800,'10,/50,:100,h,f0,n~/.vim/cache/.viminfo
set modifiable
filetype off

filetype indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"Enable code folding
set foldmethod=indent
set foldlevel=99

"--- PYTHON -->
let python_highlight_all=1

"=======================
"
"
"=======================
" PATHOGEN
"=======================

"call pathogen to infect
execute pathogen#infect()
syntax on

"======================
"
"
"======================
" VUNDLE
"======================


"set the run tim path to include Vundle and initialize
"
set rtp+=-~/.vim/bundle/Vundle.vim

call vundle#begin()

"Vim Surround is installed
"let Vundle manage Vundle,
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'MarcWeber/vim-addon-mw-utils' "this a dependancy for snipmate
Plugin 'tomtom/tlib_vim' "this a dependancy for snipmate
Plugin 'garbas/vim-snipmate'
Plugin 'davidhalter/jedi-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'crusoexia/vim-javascript-lib'
Plugin 'crusoexia/vim-monokai'
Plugin 'yggdroot/indentline'
Plugin 'flazz/vim-colorschemes' "colorschema
Plugin 'tomasr/molokai' "this is a colorschema
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim' "Autoindenting for Python
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8' "Python plugin
Plugin 'tpope/vim-fugitive'
Plugin 'digitaltoad/vim-jade'
Plugin 'jiangmiao/auto-pairs'
"Plugin 'nathanaelkane/vim-indent-guides' this plugin shows indent guide


"=======================
"-> Plugin Variables
"=======================

"--- 'tmhedberg/SimpylFold' --->
let g:SimpylFold_docstring_preview=1


"=======================
"
"

call vundle#end()

"=======================
" YOU COMPLETE ME
"=======================
"let g:ycm_global_ycm_extra_conf = ~/.vim/.ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]
let g:python_host_prog="/usr/bin/python"
let g:ycm_autoclose_preview_window_after_completion=1 "ensures that autocomplete window goes away when your done
let g:ycm_server_keep_logfiles=1
let g:ycm_server_log_level="debug"

"C/C++ YCM checker
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'
let g:syntastic_cpp_check_header = 1

map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

"ERRORS & WARNINGS
let g:ycm_error_symbol = '⚠️ '
let g:ycm_warning_symbol = '⛔️'

"=======================
"
"
"=======================
" AIRLINE
"=======================
set laststatus=2 "this is so airline can always appear"

let g:paredit_mode = 1
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>" "this is set for Utisnips
let g:UltiSnipsJumpBackwardTrigger="<c-z>" "this is set for Ultisnips
let g:airline_powerline_fonts = 1
let g:airline#extension#tabline#enabled = 1
let g:airline#extension#tabline#left_sep = ' '
let g:airline#extension#tabline#left_alt_sep = '|'

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode','','branch'])
    let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_d = airline#section#create(['%P'])
    let g:airline_section_a = airline#section#create(['%B'])
    let g:airline_section_a = airline#section#create(['%l','%c'])
endfunction
autocmd VimEnter * call AirlineInit()

"=======================
"
"
"=======================
" SYNTASTIC
"=======================

set statusline+=%warning#
set statusline+={SyntasticlineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open =1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['eslint']
" C++ Checker
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = [ '-std=c++0x','-stdlib=libc++' ]

let g:syntastic_error_symbol = "««"
"let g:syntastic_warning_symbol = "∆∆"

"=======================
" NERDTREE
" ======================
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_n")|NERDTree|endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"=======================
"
"
"=======================
" SET ALL TYPES HERE
" ======================
set t_Co=256
set background=dark

colorscheme 1989

let g:libertine_Sunset = 1

"autocmd BufEnter *.js colorscheme wolfpack
autocmd BufEnter *.js colorscheme libertine
au BufNewFile,BufRead,BufReadPost *.jade.html set filetype=jade
"autocmd BufEnter *.py colorscheme hybrid

"=======================
" C++
" ======================
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

" ======================

"italic support
"let g:monokai_italic = 1


"INDENT GUIDES
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey


let mapleader=","
syntax enable

set ignorecase
set hlsearch
set autoindent
set fileencoding=utf-8
set encoding=utf-8
set backspace=indent,eol,start
set ts=4 sts=4 sw=4 expandtab
set tabstop=4

"-- proper PEP8 indention for Python
"au BufNewfile,BufRead *.py
"\ set tabstop=4
"\ set softtabstop=4
"\ set shiftwidth=4
"\ set textwidth=79
"\ set expandtab
"\ set autoindent
"\ set fileformat=unix

"-- flagging unnecessary whitespace -->
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set smartcase
set gdefault
set incsearch
set showmatch

set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

set nolist
set guifont=Hack-RegularOblique:h20
set guioptions=aAc
set guioptions-=Be
set number
set noswapfile
set visualbell
set cursorline

set cc=80

"show syntax highlignting groups for words under cursor
nmap<C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'),col('.')),'synIDattr(v:val, "name")')
endfunc

"==========================
" NMAPS & AUTOCMD
"==========================
nmap<F8> :TagbarToggle<CR>

"-------GO-LANG----------->
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
"we want to get rid of accidental trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
"tell vim to allow you to copy between files, remember your cursor
set viminfo='100,\"2500,:200,%,n~/.viminfo
"=========================
"
"----- set CTRL Movements--->
"Instead of using <crtl-w-h,j,k,l> remap it
"nnoremap -> this remaps one key combination to another

nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

"-------- Enable folding with the spacebar
nnoremap <space> za

"-------- Quit files with <Shift-q>
nnoremap <C-q> :q<cr>
inoremap <C-q> <C-c>:q<cr>

"------- Compile and run C++ programs from Vim
nnoremap <C-c> :!g++ -o %:r.out % -std=c++11<Enter>
nnoremap <C-x> :!./%:r.out

"-------- Save files with <Shift-s>
nnoremap <C-s> :w<cr>
"inoremap <C-s> <C-c>:w<cr>
"runs `source % || so %` after saving
"
"tab
nnoremap th :tabfirst<cr>
nnoremap tl :tablast<cr>
nnoremap tn :tabnew<cr>
nnoremap tj :tabprev<cr>
nnoremap tc :tabclose<cr>

autocmd! BufWritePost .vimrc source %
