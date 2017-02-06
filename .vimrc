set shiftwidth=4
set softtabstop=4
set number
syntax on
set autoindent
set expandtab
set smartcase
set hlsearch
set nohidden
set incsearch
set backspace=2
set wildmenu
set wildmode=list:longest,full
inoremap jk <C-[>
noremap <Up> <NOP>
noremap <Down> <NOP>
set wildchar=<Tab> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>
nnoremap <Space> @q
map <Left> :bprevious<CR>
map <Right> :bnext<CR>
nmap <silent> <MiddleMouse> :bp\|bd #<CR>
nnoremap <C-c> :bp\|bd #<CR>
