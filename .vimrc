" Don't try to be vi compatible
set nocompatible

" Seamless integration with system clipboard
" Requires +clipboard support in the `vim --version`
set clipboard=unnamed

" Helps force plugins to load correctly when it is turned back on below
filetype off

" VUNDLE
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" TODO: Load plugins here (pathogen or vundle)
Plugin 'sheerun/vim-polyglot'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
" END VUNDLE

" Event hooks (e.g. trailing whitespace removal)
autocmd BufWritePre * %s/\s\+$//e

" Finding files
map <C-e> :NERDTreeToggle<CR>
map <C-f> :FZF<CR>

" Turn on syntax highlighting
syntax on

" For plugins to load correctly
filetype plugin indent on

" TODO: Pick a leader key
let mapleader = ","

" Show line numbers
set number
highlight LineNr ctermfg=DarkGrey
" git-gutter colors
highlight! link SignColumn LineNr
highlight GitGutterAdd    ctermfg=2
highlight GitGutterChange ctermfg=3
highlight GitGutterDelete ctermfg=1

" Show file stats
set ruler

" Encoding
set encoding=utf-8

" Whitespace
set wrap
set textwidth=79
set formatoptions=qrn1
" set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

set ttimeoutlen=1

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
set showmode
set showcmd

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
hi Search ctermfg=white ctermbg=92
set incsearch
set ignorecase
set smartcase " ignore case unless search includes UPPER CASE
map <leader><space> :let @/=''<cr> " clear search

" Textmate holdouts

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized

let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0

