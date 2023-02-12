alias gip='git push'
alias gip='git pull'

alias gia='git_add'
function git_add() {
  echo
  added_files=$(git diff --name-only | fzf --multi)
  if [ -n "$added_files" ]; then
    echo -e "$(c_light_gray "Added file:")"
    while read -r file; do
      git add "$file"
    echo -e "$(c_cyan "    $added_files")"
    done <<< "$added_files"
    use_commit
  else
      echo "No files selected."
  fi
}

function use_commit() {
  echo
  echo "$(c_green "Do you want to commit files above?") (Y/n)"
        read -r CONFIRM_CONFIRM;
  if [ "$CONFIRM_CONFIRM" = "y" ] || [ -z "$CONFIRM_CONFIRM" ]; then
      git_commit
  else
        echo "Okay, you can commit later."
  fi
}

alias gic='git_commit'
function git_commit() {
       echo
       echo "$(c_green "What's the commit name?") (Y/n)"
       read -r COMMIT_NAME;
       echo "$(c_green "Do you want to use --no-verify option?") (Y/n)"
       read -r VERIFY
       if [ "$VERIFY" = "y" ] || [ -z "$VERIFY" ]; then
         git commit -m "$COMMIT_NAME" --no-verify
       else
         git commit -m "$COMMIT_NAME"
       fi
       git_push
}

function git_push() {
       echo "$(c_green "Do you want to push now") (Y/n)?"
       read -r CONFIRM_PUSH;
       if [ "$CONFIRM_PUSH" = "y" ] || [ -z "$CONFIRM_PUSH" ]; then
         git push
       else
         echo "Okay, you can push later."
       fi
}
