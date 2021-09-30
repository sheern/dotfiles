" Don't try to be vi compatible
set nocompatible

" COMMA LEADER
let mapleader = ","

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
" Requires node in $PATH (check with 'which node')
Plugin 'neoclide/coc.nvim'
Plugin 'sheerun/vim-polyglot'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'itchyny/lightline.vim'
Plugin 'preservim/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

call vundle#end()
" For plugins to load correctly
filetype plugin indent on
" END VUNDLE

" Event hooks (e.g. trailing whitespace removal)
autocmd BufWritePre * %s/\s\+$//e

" Finding files
map <C-e> :NERDTreeToggle<CR>

" Tab pages
nnoremap <C-t> :tabnew<CR>

" Open fugitive split
nnoremap <leader>g :Git<CR>

" Turn on syntax highlighting
syntax on

" Show line numbers
set number
highlight LineNr ctermfg=DarkGrey
" vsplit same color as background
highlight VertSplit cterm=NONE

" Show file stats
set ruler

" Encoding
set encoding=utf-8

" Whitespace
" Handled by vim-polyglot for most filetypes but keep around for files like
" .vimrc
set wrap
" r and o, insert comment leader character(s) on next line
set formatoptions=ro
set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

" Cursor motion
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> " use % to jump between pairs
runtime! macros/matchit.vim

" Create a temporary session (useful for refreshing vim
" when sourcing .vimrc is insufficient
nnoremap <leader>ss :mksession! ~/.tmpsession.vim<CR>
" Load the temporary session
nnoremap <leader>sl :source ~/.tmpsession.vim<CR>

" Move up/down editor display lines (effective when line wraps)
nnoremap j gj
nnoremap k gk
" Insert a new line below, stay in normal mode
nnoremap <Enter> o<Esc>
" Don't use this mapping in the command history or quickfix window
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>
" Break the line at cursor, stay in normal mode
nnoremap <leader><Enter> i<CR><Esc>

" Rendering
set ttyfast

" Status bar
set laststatus=2

" Last line
" Status line will show mode, don't need to show on last line
set noshowmode
set showcmd

set pastetoggle=<leader>p

" Searching
nnoremap / /\v
vnoremap / /\v
set hlsearch
highlight Search ctermfg=white ctermbg=53
highlight MatchParen ctermfg=black
set incsearch
set ignorecase
set smartcase " ignore case unless search includes UPPER CASE
map <leader><space> :let @/=''<cr> " clear search

" Visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬
" Uncomment this to enable by default:
" set list " To enable by default
" Or use your leader key + l to toggle on/off
map <leader>l :set list!<CR> " Toggle tabs and EOL

" BUFFER SWITCHING
" Ctrl-c to close current buffer and change current window to previous buffer
nnoremap <C-c> :bp\|bd #<CR>
" Don't use this mapping in command window (<C-c> closes command window)
autocmd CmdwinEnter * nnoremap <buffer> <C-c> <C-c>
" Open fzf for all files in cwd
nnoremap <leader>f :Files<CR>
" Open fzf for listed buffers
nnoremap <leader>b :Buffers<CR>

" SPLITS
" Resize equally within each split
nnoremap <leader>= <C-w>=<CR>

" Quickly edit and source .vimrc
nnoremap <leader>ve :tabnew $MYVIMRC<CR>
" This mapping is useful if you edited .vimrc in another vim instance
" But the autocmd will handle the usual case of editing .vimrc in the same instance using <leader>ve
nnoremap <leader>vr :source $MYVIMRC<CR>
autocmd BufWritePost .vimrc normal ,vr

" COLORS
let g:lightline = { 'colorscheme': 'darcula' }
" Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
" colorscheme solarized
highlight SignColumn ctermbg=NONE

" Display all highlight colorings in a split
nnoremap <leader>h :so $VIMRUNTIME/syntax/hitest.vim<CR>

" ===================================================
" =================== FZF ===========================
" ===================================================
function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

" :BD to delete highlighted buffers
" shift-tab to multi-select
command! BD call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
            \ }))
" ===================================================
" ===================================================
" ===================================================

" =======================================================================
" =================== CONQUERER OF COMPLETION ===========================
" =======================================================================
" Fix the horrendous pink background color
hi CocFloating ctermbg=233
hi FgCocErrorFloatBgCocFloating ctermbg=233
hi FgCocInfoFloatBgCocFloating ctermbg=233
hi FgCocWarningFloatBgCocFloating ctermbg=233

nnoremap <C-n> :call CocAction('diagnosticNext')<CR>
nnoremap <C-p> :call CocAction('diagnosticPrevious')<CR>
" =======================================================================
" =======================================================================
" =======================================================================
