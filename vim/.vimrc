" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set wildmode=longest,longest,list,full
set wildmenu

au FileType * setl fo-=cro

set number

set backupdir=~/.vimbackups

set tabstop=4

set clipboard=unnamed
set shiftwidth=4
set expandtab

set autoindent
set tw=100
set fo-=t

au FileType markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0
autocmd FileType c,cpp,java,php,py autocmd BufWritePre <buffer> %s/\s\+$//e
au FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neomake/neomake'
Plug 'mg979/vim-visual-multi'
Plug 'keith/swift.vim'
Plug 'fatih/vim-go'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'leafgarland/typescript-vim'
Plug 'rust-lang/rust.vim'
Plug 'vhda/verilog_systemverilog.vim'
Plug 'github/copilot.vim', { 'branch': 'release' }
Plug 'prettier/vim-prettier'
call plug#end()

colorscheme vim

let g:rustfmt_autosave = 1

let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0

autocmd! BufWritePost,BufEnter * Neomake
au BufNewFile,BufRead *.twig,*.jinja set filetype=jinja

autocmd FileType tf setlocal shiftwidth=2 tabstop=2

let g:neomake_python_python_exe = 'python3'

let g:neomake_python_pycodestyle_maker = {
    \ 'args': ['--max-line-length=200'],
    \ 'errorformat': '%f:%l:%c: %m',
    \ 'postprocess': function('neomake#makers#ft#python#Pep8EntryProcess')
    \ }

let g:neomake_cpp_enabled_makers = []
let g:neomake_go_enabled_makers = ['go', 'govet']

let g:copilot_settings = #{ selectedCompletionModel: 'gpt-4o-copilot' }
let g:copilot_integration_id = 'vscode-chat'

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

let g:VM_maps = {}
let g:VM_maps['Exit'] = '<C-c>'

imap ‘ <Plug>(copilot-next)
imap “ <Plug>(copilot-previous)

let g:copilot_filetypes = {
   \ 'markdown': v:true,
   \ }
