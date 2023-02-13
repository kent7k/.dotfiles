alias cdd='select_cd_option'

function select_cd_option() {
  echo
  echo -e "$(c_green "Select cd option")"
  echo -e "$(c_green "  1: cdd - to a directory directly one accessed before")"
  echo -e "$(c_green "  2: cdr - to a directory of repository'")"
  echo -e "$(c_green "  3: fd  - to a directory (=All directories)'")"
  read -r SELECT_CD_TYPE
  case "$SELECT_CD_TYPE" in
    [1]) fzf-cdr ;;
    [2]) fzf-ghq ;;
    [3]) fd ;;
    *) echo "Push number key." ;;
  esac
}

# cdd - cd to selected directory directly one accessed before
alias cddd='fzf-cdr'
function fzf-cdr() {
  target_dir=$(cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf)
  if [ -n "$target_dir" ]; then
    cd "${target_dir/#\~/$HOME}"
  fi
}

# cdr - cd to selected directory of repository
alias cdr='fzf-ghq'
function fzf-ghq() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^]' ghq-fzf

# fd - cd to selected directory
# Note: find command makes a list from current to the lower layer,
#       then pass stdout to fzf, and finally pass the result to cd command.
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2>/dev/null | fzf +m) &&
    cd "$dir"
}
