set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Plugin 'OmniSharp/omnisharp-vim' buggy so disabling
Plugin 'hashivim/vim-terraform'
Plugin 'neoclide/coc.nvim'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set shiftwidth=4
set softtabstop=4
set number
syntax on
set autoindent
set expandtab
set smartcase
set hlsearch
set hidden
set incsearch
set backspace=2
set wildmenu
set wildmode=list:longest,full
inoremap jk <C-[>
"noremap <Up> <NOP>
"noremap <Down> <NOP>
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <f10> :b <c-z>
" nnoremap <space> @q disabling this because its freezing vim
map <Left> :bprevious<CR>
map <Right> :bnext<CR>
nmap <silent> <MiddleMouse> :bp\|bd #<CR>
nnoremap <C-c> :bp\|bd #<CR>

" nerdtree stuff
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
set shell=bash\ -l
let g:NERDTreeChDirMode = 2  " Change cwd to parent node
let g:NERDTreeMinimalUI = 1  " Hide help text
let g:NERDTreeAutoDeleteBuffer = 1

autocmd Filetype html setlocal sts=2 sw=2 expandtab
autocmd Filetype javascript setlocal sts=2 sw=2 expandtab
autocmd Filetype typescript setlocal sts=2 sw=2 expandtab

"https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
"https://www.freecodecamp.org/news/fzf-a-command-line-fuzzy-finder-missing-demo-a7de312403ff/
"rg --no-column --line-number --heading --no-ignore --no-hidden --follow --fixed-strings --color "always" 'Title Search'

"rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob '!.git/*' --color "always" 'Title Search'
command! -bang -nargs=* Find call fzf#vim#grep('rg --fixed-strings --color "always" '.shellescape(<q-args>), 1, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


" https://github.com/andreasvc/vim-256noir colorscheme
" https://gist.github.com/u0d7i/01f78999feff1e2a8361
set mouse=a
set cb=unnamed
set background=light

" fix for meaning to press w but press W which causes a window to pop up
:command W w
" https://unix.stackexchange.com/questions/88714/how-can-i-do-a-change-word-in-vim-using-the-current-paste-buffer
:map <C-j> "_cw<C-r>*<ESC>

" https://www.reddit.com/r/neovim/comments/5usi1q/how_to_change_tab_or_window_once_in_terminal/
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l


" COC
"TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
highlight SignColumn ctermbg=none
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"https://github.com/fatih/vim-go/issues/2256

