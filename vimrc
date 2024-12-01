set hlsearch 
set nu 
set autoindent 
set scrolloff=2
set wildmode=longest,list
set ts=4 
set sts=4 
set sw=1 
set autowrite 
set autoread 
set cindent 
set bs=eol,start,indent
set history=256
set laststatus=2 
set shiftwidth=4 
set showmatch 
set smartcase 
set smarttab
set smartindent
set softtabstop=4
set tabstop=4
set expandtab
set ruler 
set incsearch
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
set guioptions-=T
set nowrap
"set cursorline

"set list
"set list listchars=set nocompatible              " be iMproved, required


filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
"Plugin 'mg979/vim-visual-multi', {'branch': 'master'}
"set runtimepath+=/home/logan.js.lee/.vim/plugin
call vundle#end()            " required
filetype plugin indent on    " requiredtab:·\ ,trail:·,extends:>,precedes:<

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

if $LANG[0]=='k' && $LANG[1]=='o'
"set fileencoding=korea
endif

if has("syntax")
 syntax on
endif

"colorscheme gruvbox
colorscheme desert
set background=dark
set guifont=Monospace\ 14
"set guifont=HackNerdFont\ 9.5

"au BufNewFile *.sv so /home/logan.js.lee/.vim/syntax/systemverilog.vim
"au BufRead *.sv so /home/logan.js.lee/.vim/syntax/systemverilog.vim
"au BufNewFile *.py so /home/logan.js.lee/.vim/syntax/python.vim
"au BufRead *.py so /home/logan.js.lee/.vim/syntax/python.vim
"au BufNewFile *.rs so /home/logan.js.lee/.vim/syntax/rust.vim
"au BufRead *.rs so /home/logan.js.lee/.vim/syntax/rust.vim
"au BufNewFile *.c so /home/logan.js.lee/.vim/syntax/c.vim
"au BufRead *.c so /home/logan.js.lee/.vim/syntax/c.vim
"au BufNewFile *.cpp so /home/logan.js.lee/.vim/syntax/cpp.vim
"au BufRead *.cpp so /home/logan.js.lee/.vim/syntax/cpp.vim
"let g:python_highlight_all = 1


inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" LSP 자동 완성
autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

" 진단 메시지 설정
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
