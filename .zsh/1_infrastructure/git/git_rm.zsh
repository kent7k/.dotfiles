function git_rm() {
  echo "\n$(c_red "Remove file from repository index but keep it untouched locally?") (y/N)"
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
    echo "$(c_red "Do you want to force push? (Need to resolve conflicts on remote repository)") (y/N)"
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
  echo -e "$(c_light_gray "Cashed file:")"
  while read -r file; do
    echo -e "$(c_cyan "  - $file")"
  done <<<"$target"

  # Confirm
  echo "$(c_red "Remove cached file that removed from git?") (y/N)"
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
