alias gip='git push'
alias gip='git pull'

alias gia='git_add'
function git_add() {
  added_files=$(git diff --name-only | fzf --multi)
  if [ -n "$added_files" ]; then
    while read -r file; do
      git add "$file"
      echo -e "$(c_light_gray "Added file:") $(c_cyan "$added_files")"
    done <<< "$added_files"
    use_commit
  else
      echo "No files selected."
  fi
}

alias gic='gic'
function use_commit() {
          echo "Do you want to commit now (y/n)?"
          read -r -n 1 CONFIRM;
          if [ "$CONFIRM" == "y" ]; then
            git_commit
          else
            echo "Okay, you can commit later."
          fi
}

function git_commit() {
       echo "What's the commit name?"
       read -r COMMIT_NAME;
       echo "Do you want to use --no-verify option? (y/n) [n]:"
       read -r -n 1 VERIFY
       VERIFY=${VERIFY:-n}
       if [ "$VERIFY" = "y" ]; then
         git commit -m "$COMMIT_NAME" --no-verify
       else
         git commit -m "$COMMIT_NAME"
       fi
       git_push
}

function git_push() {
       echo "Do you want to push now (y/n)?"
       read -r CONFIRM;
       if [ "$CONFIRM" == "y" ]; then
         git push
       else
         echo "Okay, you can push later."
       fi
}
