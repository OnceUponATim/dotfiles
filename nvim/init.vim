set nocompatible            " Disable compatibility to vi
set showmatch               " Show matching brackets
set ignorecase              " Case insenstive matching
set hlsearch                " Highlight searches

" Indentation
set tabstop=4               " Tab size in spaces
set softtabstop=4           " Set x spaces as tab-stop for <BS>
set shiftwidth=4            " >>, ==, and << to 4 spaces
set shiftround              " Indent to sentence, not before
set expandtab               " Tab -> Spaces
set autoindent              " Auto indentation as previous-line
set copyindent              " Auto indentation from copy
set smarttab                " Use smarttab scheme

" Wrapping and formatting
set nowrap                  " do not wrap text
set linebreak               " DO NOT WRAP TEXT :)
set textwidth=82            " maxtext to show is 82 cols 
set number                  " Add line numbers
set wildmode=longest,list   " Bash like tab completions
set cc=82                   " Line at 82 blocks

" backup and history
set nobackup                " stop atuobackup
set noswapfile              " Stop autoswapfile annoyance
set nomodeline              " Dont read modelines
set modelines=0             " First modeline to read is line 0
set undofile                " Undofile option
set history=1000            " Set history to 1000
set undolevels=1000         " Undo max 10000
set cursorline              " show which line im on
syntax on                   " set syntax one
syntax sync minlines=256    " Start highlighting from 256 lines backwards
set synmaxcol=300           " Max column to highlight


" Keymappings
" Set leader
let mapleader = ";"

"reload vim config
nnoremap <silent> <leader>sv :so ~/.config/nvim/init.vim<CR>

" Save as SUDO
nnoremap ZS :w !sudo tee %<CR><CR>

" Remove search highlighting
nnoremap <BS> :set hls!<CR>

" Goto definition
nnoremap gd :YcmCompleter GoTo<CR>

" fold/unfold indent
nnoremap <space> za
set foldlevelstart=99

" Splits settings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Left> 5<C-w><
nnoremap <Right> 5<C-w>>
nnoremap <Up> 5<C-w>+
nnoremap <Down> 5<C-w>-

" Fuzzy search files
map \ :Files <CR>
map <C-o> :NERDTreeToggle<CR>

" Page displacement
vnoremap J 5j
vnoremap K 5k
nnoremap J 5j
nnoremap K 5k
nnoremap H ^
nnoremap L $

" Carret movement
map <tab> %
nnoremap n nzzzv<CR>
nnoremap N Nzzzv<CR>
nnoremap } }zz
nnoremap { {zz

" Move line up or down
nnoremap <C-d> :m +1<CR>
nnoremap <C-u> :m -2<cr>

" comment line
nnoremap <C-/> ;c<space>
" Show hidden symbols
nnoremap <leader>l :set list!<cr>
set listchars=eol:¬,trail:-,nbsp:+,tab:>-,space:⁃

" align at '='
vnoremap <leader>a :Tab /=<CR>

" toggle bool (;inverse)
noremap <leader>i :ToggleBool<CR>

" Set color scheme
colorscheme tir_black

" Include and initialize Vundle
filetype off
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Load vim plugins
Plugin 'vim-syntastic/syntastic'    " Linter for pylint
Plugin 'airblade/vim-gitgutter'     " Show differences from files
Plugin 'Valloric/YouCompleteMe'     " Auto-complete YCM
Plugin 'tmhedberg/SimpylFold'       " Better folding
Plugin 'scrooloose/nerdcommenter'   " Commenting/uncommenting
Plugin 'sagarrakshe/toggle-bool'    " Toggle ture/false on/of
Plugin 'godlygeek/tabular'          " Auto indentation
"Plugin 'junegunn/fzf.vim'           " Fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'         " Fuzzy file navigator
Plugin 'terryma/vim-multiple-cursors' " Multicursor CTRL+N c-I-A
Plugin 'tpope/vim-surround'         " Surround with []{}()
Plugin 'scrooloose/nerdtree'        " Dirtree
Plugin 'mattn/emmet-vim'            " EMMET :)
Plugin 'Shougo/deoplete.nvim'       " Asynchronous C lang completions
Plugin 'zchee/deoplete-clang'       " Code copmletions clang
Plugin 'rhysd/vim-clang-format'     " Autoformatting
Plugin 'skywind3000/asyncrun.vim'   " Async commandj
Plugin 'ivanov/vim-ipython'         " Nvim jupyter integration
Plugin 'tmhedberg/matchit'          " Match XML tags


" stop end plugins loading
call vundle#end()
filetype plugin indent on   " allows autio-indenting depending on filetype

" Statusline from github kniren
function! StatuslineMode()
    let l:currentMode = mode()
    if l:currentMode == 'n'
        hi User1 ctermbg=0 cterm=bold
        return '  ' . 'N' . ' '
    elseif l:currentMode == 'r'
        hi User1 ctermbg=1 cterm=bold
        return '  '. 'R' . ' '
    elseif l:currentMode == 'i'
        hi User1 ctermbg=4 cterm=bold
        return '  '. 'I' . ' '
    elseif l:currentMode == 'v'
        hi User1 ctermbg=6 cterm=bold
        return '  '. 'V' . ' '
    else
        hi User1 ctermbg=0 cterm=bold
    endif
    return ' ' . 'VB' . ' '
endfunction
set statusline=%#User1#
set statusline+=%{StatuslineMode()}
set statusline+=%*
set statusline+=\ %t
function! Fugitive()
    try
        let sl=fugitive#head()
    catch
        return ''
    endtry

    if sl == ''
        return ''
    endif
    return ' >> ' . sl
endfunction
set statusline+=%{Fugitive()}
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
set statusline+=%l,%c
set statusline+=\ \«\ %L
set statusline+=\ \«\ %P\ %#User1#\ %Y\ %*


" Syntastic settings
let g:syntastic_mode_map = { 'mode' : 'passive', 'active_filetypes': [], 'passive_filetypes':[] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ["pylint"]
let g:syntastic_python_pylint_exe = 'python -m pylint'

" YouCompleteMe settings
let g:ycm_confirm_extra_conf = 0

" SimplyFold NO AUTO FOLDING
let g:SimpylFold_fold_import = 0
let b:SimpylFold_fold_import = 0 

"Async run
let g:asyncrun_open = 10
let g:asyncrun_status = "stopped"
augroup QuickfixStatus
    au! BufWinEnter quickfix setlocal
        \ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%1,%c%V%)\ %P
augroup END

" C/CPP
augroup ft_cpp
    au!
    let g:gutentags_enabled = 1
    set makeprg=ninja\ -C\ build
    let g:clang_format#code_style = 'google'
    let g:clang_format#detect_style_file = 1
    noremap <leader>f :ClangFormat<CR>
    " Deoplete-clang
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
    let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

    au FileType cpp nnoremap <buffer> <F5> :AsyncRun -cwd=<root> mkdir -p build && cd build && cmake .. -G Ninja -DCMAKE_BUILD_TYPE=Release && cd .. && ninja -C build<cr>
    
