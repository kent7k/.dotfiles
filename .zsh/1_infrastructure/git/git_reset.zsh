alias gire='git_reset'
function git_reset() {
  printf "\n%s\n" "$(c_green "Do you want to reset repository?") (y/N)"
  read -r CONFIRM_RESET
  if [ "$CONFIRM_RESET" = "y" ]; then
    echo -e "$(c_green "  1: Return back 'add' (=Unstage everything)")"
    echo -e "$(c_green "  2: Return back 'added specific file'")"
    echo -e "$(c_green "  3: Return back 'commit'")"
    echo -e "$(c_green "  4: Reset 'any uncommitted changes, staged or not  (for only unstaged changes)'")"
    echo -e "$(c_green "  5: Reset 'add, commit, change'")"
    read -r RESET_TYPE
    case "$RESET_TYPE" in
      [1]) git reset ;;
      [2]) git reset --patch path/to/file ;;
      [3]) git reset --soft HEAD~ ;;
      [4]) git reset --hard ;;
      [5]) git reset --hard HEAD~ ;;
      *) echo "Push number key." ;;
    esac
  else
    echo "Okay, you can reset repository later."
  fi
}

function git_clean_untracked_files() {
  # FIXME
  printf "\n%s\n" "$(c_green "Do you want to clean files?")"
  git clean -i
}

function reset_repository_commit_log() {
  echo
  c_red "[ WARNING ]"
  echo "$(c_red "Do you want to reset commit log?") (yes/N)"
  read -r CONFIRM_RESET_COMMIT
  if [ "$CONFIRM_RESET_COMMIT" = "yes" ]; then
    git checkout --orphan latest_branch
    git add -A
    git commit -am "commit message"
    git branch -D main
    git branch -m main
    git push -f origin main
  else
    echo "Okay, you can reset commit log later."
  fi
}
