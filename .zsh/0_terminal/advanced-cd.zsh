alias cdd='select_cd_option'

function select_cd_option() {
  echo
  printf "%sSelect cd option%s\n" "${GREEN}" "${NORMAL}"
  printf "  %s1: cdd - to a directory directly one accessed before%s\n" "${GREEN}" "${NORMAL}"
  printf "  %s2: cdr - to a directory of repository'%s\n" "${GREEN}" "${NORMAL}"
  printf "  %s3: fd  - to a directory (=All directories)'%s\n" "${GREEN}" "${NORMAL}"
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
    cd "${target_dir/#\~/$HOME}" || exit
  fi
}

# cdr - cd to selected directory of repository
alias cdr='fzf-ghq'
function fzf-ghq() {
  local src
  src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
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
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
    -o -type d -print 2>/dev/null | fzf +m) &&
    cd "$dir"
}
