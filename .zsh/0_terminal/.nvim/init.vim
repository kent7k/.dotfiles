"--- Dein Config ---"
set nocompatible
let s:dein_base = '$HOME/.cache/dein'
let s:dein_src = '$HOME/.cache/dein/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_src
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
if has('filetype')
  filetype indent plugin on
endif

"--- Syntax Highlighting ---"
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
if dein#check_install()
 call dein#install()
endif
