function git_rm() {
  printf "\n%sRemove file from repository index but keep it untouched locally?%s (y/N)\n" "${RED}" "${NORMAL}"
  read -r CONFIRM_REMOVE_FROM_INDEX
  if [ "$CONFIRM_REMOVE_FROM_INDEX" = "y" ]; then

    # FIXME: This function may not work for derectory.
    target=$(git ls-files | fzf)
    if [ -f "$target" ]; then
      git rm --cached "$target"
    elif [ -d "$target" ]; then
      git rm --cached -r "$target"
    fi

    echo
    printf "%sDo you want to force push? (Need to resolve conflicts on remote repository)%s (y/N)\n" "${RED}" "${NORMAL}"
    git_force_push
    rm_cached_file_that_removed_from_git "$target"

  else
    echo "Okay, you can remove file from repository index later."
  fi
}

# FIXME: This function may not work for multiple files. Only a file or a directory.
function rm_cached_file_that_removed_from_git() {
  target="$1"
  echo

  # List Target
  printf "${LIGHT_GRAY}Cashed file:%s\n" "${NORMAL}"
  while read -r file; do
    echo -e "${CYAN}  - $file${NORMAL}"
  done <<<"$target"

  # Confirm
  printf "%sRemove cached file that removed from git?%s (y/N)\n" "${RED}" "${NORMAL}"
  read -r CONFIRM_REMOVE_CACHED_FILE
  if [ "$CONFIRM_REMOVE_CACHED_FILE" = "y" ]; then
    if [ -f "$target" ]; then
      rm "$target"
    elif [ -d "$target" ]; then
      rm -r "$target"
    fi
  else
    echo "Okay, you can remove cached file later."
  fi
}
