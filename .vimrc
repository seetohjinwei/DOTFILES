syntax on
" use new regex engine
set re=0
set nocompatible
set shortmess+=I
set number
set relativenumber
set laststatus=2
set hlsearch
set hidden
set wrap

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
" set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support.
set mouse+=a

" Tab will insert 2 spaces
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set smartindent

" set scrolloff=4
set signcolumn=yes
set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

set cmdheight=2
set updatetime=100

" syncs with OS clipboard
set clipboard=unnamed

" enhanced tab completion
set wildmenu

try
    set undodir=~/.vim/undodir
    set undofile
catch
endtry

" Plugins
call plug#begin('~/.vim/plugged')

" colorschemes
" Plug 'flazz/vim-colorschemes'
Plug 'sainnhe/everforest'

" automatically closes quotes, parentheses, ...
Plug 'raimondi/delimitmate'
" rainbow parentheses
Plug 'luochen1990/rainbow'
" statusline / tabline thing at the bottom
Plug 'itchyny/lightline.vim'
" file tree
Plug 'preservim/nerdtree'
" highlights the yanks
Plug 'machakann/vim-highlightedyank'
" commenting stuff out - gc, gcc
Plug 'tpope/vim-commentary'
" changes surrounding quotes, parentheses, ...
Plug 'tpope/vim-surround'
" detects tabstop and shiftwidth automatically
" Plug 'tpope/vim-sleuth'
" case-preserving substitute (Subvert) + switching between cases (Coercion)
" :S/child{,ren}/adult{,s}/g
" crs (snake_case), crm (TitleCase), crc (camelCase), cru (UPPER_CASE)
Plug 'tpope/vim-abolish'

" tmux
Plug 'christoomey/vim-tmux-navigator'

" fzf - fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git fugitive
Plug 'tpope/vim-fugitive'
" git signs gutter
Plug 'airblade/vim-gitgutter'

" better auto-completion engine
Plug 'girishji/vimcomplete'

" auto-completion for command line
Plug 'girishji/autosuggest.vim'

" language support
" syntx highlighting + other nice stuff
Plug 'sheerun/vim-polyglot'

Plug 'fatih/vim-go'

call plug#end()

" colorscheme
" colorscheme 0x7A69_dark
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme everforest
" colorscheme happy_hacking
" colorscheme ayu

" https://github.com/kovidgoyal/kitty/issues/108#issuecomment-320492663
" vim hardcodes background color erase even if the terminfo file does
" not contain bce (not to mention that libvte based terminals
" incorrectly contain bce in their terminfo files). This causes
" incorrect background rendering when using a color theme with a
" background color.
" let &t_ut=''

" https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
" Enables italic support
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic " Not needed because everforest already does this

let g:lightline = {'colorscheme' : 'everforest'}

" rainbow
let g:rainbow_active = 1

" NERDTree
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

set wildignore+=*.class
let NERDTreeRespectWildIgnore=1

let g:highlightedyank_highlight_duration = 300

" override rust.vim's bad override of <> auto-complete
au FileType rust let b:delimitMate_matchpairs = "(:),[:],{:}"

" show trailing whitespace
highlight ExtraWhitespace ctermbg=darkred guibg=darkred
match ExtraWhitespace /\s\+$/
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Keybindings
let mapleader=";"
" nnoremap <leader>[ <C-u>
" nnoremap <leader>] <C-d>
nnoremap <silent> <leader>tt :vsplit<CR>
nnoremap <silent> <leader>ty :split<CR>
nnoremap <silent> <leader>tw :close<CR>
nnoremap <silent> <leader>; mpA;<Esc>`p:delmarks p<CR>
inoremap <silent> <leader>; <Esc>mpA;<Esc>`p:delmarks p<CR>a
inoremap <silent> ;l ;
inoremap <leader><CR> <Esc>o
inoremap <leader>c <Esc>cc
nnoremap <silent> <leader>tm :botright terminal<CR>
nnoremap <silent> <leader>l :noh<CR>
" handle soft wrap
" vscode vim doesn't support this, but they have a setting for it
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <silent> <C-s> <C-a>

" pane navigation (vim-tmux-navigator does this too)
" nmap <silent> <c-k> :wincmd k<CR>
" nmap <silent> <c-j> :wincmd j<CR>
" nmap <silent> <c-h> :wincmd h<CR>
" nmap <silent> <c-l> :wincmd l<CR>

" https://stackoverflow.com/a/597932
" local rename
nnoremap <leader>rn gd[{V%::s/<C-R>///gc<left><left><left>
" global rename
nnoremap <leader>rN gD:%s/<C-R>///gc<left><left><left>

" fugitive
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>GS :Git
nnoremap <silent> <leader>gb :Git blame<CR>
autocmd Filetype fugitive nnoremap <buffer> <silent> <leader>gs :close<CR>

" splitjoin
let s:sj_enabled = 0
let s:sj_pos = [-1,-1,-1,-1]
function SplitJoin()
  if s:sj_enabled && string(getpos('.')) == string(s:sj_pos)
    " split
    echom 'split'
    :exe "normal gS"
    let s:sj_enabled = 0
  else
    " join
    echom 'join'
    :exe "normal gJ"
    let s:sj_enabled = 1
  endif

  if s:sj_enabled
  else
  endif

  let s:sj_pos = getpos('.')

endfunction
" nnoremap <silent> <leader>sj :call SplitJoin()<CR>

function! ExpandList(type, ...)
  silent s/\%V.*\%V/\="\r" . submatch(0)
        \ ->split(',')
        \ ->map({ i, v -> v->trim()})
        \ ->join(",\r") . "\r"/g
  silent normal ='[
endfunction
" <in normal mode> ;sj <motion>
" <in normal mode> ;sj va[   (if working with [A, B])
nnoremap <silent> <leader>sj :set opfunc=ExpandList<CR>g@
" to join them back:
" va[J

" nerdtree
function NERDTreeUtil()
  if stridx(bufname('%'), 'NERD_tree_') >= 0
    execute ':NERDTreeClose'
  else
    execute ':NERDTreeFocus'
  endif
endfunction
nnoremap <silent> <leader>e :call NERDTreeUtil()<CR>
nnoremap <silent> <leader>E :NERDTreeClose<CR>
let g:NERDTreeMapOpenExpl = 'E'

" fzf
nnoremap <silent> <leader>sf :Files<CR>
nnoremap <silent> <leader>sg :Rg<CR>
nnoremap <silent> gr :Rg <C-r><C-w><CR>

" tmux
let g:tmux_navigator_no_wrap = 1

autocmd Filetype java nnoremap <buffer> tp ipublic class <C-r>=expand('%:r')<CR> {<CR>}<esc>O
autocmd Filetype c,cpp nnoremap <leader>rr :!gcc -Wall -Wextra -o %< % && ./%<<CR>
" override vim-sleuth
autocmd Filetype go setlocal tabstop=2 shiftwidth=2 softtabstop=2
" for ocaml
set rtp^="/Users/jinwei/.opam/default/share/ocp-indent/vim"
