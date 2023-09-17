"--- Dein Config ---"
" Ward off unexpected things that your distro might have made, as
" well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Set Dein base path (required)
let s:dein_base = '$HOME/.config/nvim/dein'

" Set Dein source path (required)
let s:dein_src = '$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim'

" Set Dein runtime path (required)
execute 'set runtimepath+=' . s:dein_src

" Call Dein initialization (required)
call dein#begin(s:dein_base)

call dein#add(s:dein_src)


"--- Use Plugins ---"
let g:rc_dir = expand('~/ghq/.dotfiles/.zsh/0_terminal/.nvim')
let s:toml = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
call dein#load_toml(s:toml, {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})
call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })


"--- Finish Dein Initialization ---"
call dein#end()


"--- File Type Specific Settings ---"
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif


"--- Syntax Highlighting ---"
" Enable syntax highlighting
if has('syntax')
  syntax on
endif


"--- User Config ---"
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 14
set guifontwide=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 14
set number
set mouse+=a
set clipboard=unnamed

"--- Color ---"
highlight CursorLineNr ctermbg=darkblue ctermfg=lightcyan
highlight lineNr ctermfg=darkgray
highlight DiffAdd ctermbg=none
highlight DiffChange ctermbg=none ctermfg=yellow
highlight DiffText ctermbg=blue ctermfg=yellow
highlight SignColumn ctermbg=none ctermfg=yellow
set cursorline
highlight clear CursorLine


"--- Plugin Install ---"
" Uncomment if you want to install not-installed plugins on startup.
if dein#check_install()
 call dein#install()
endif
