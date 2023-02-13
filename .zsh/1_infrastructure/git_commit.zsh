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
      echo -e "$(c_cyan "  - $file")"
    done <<<"$added_files"
    use_commit
  else
    echo "No files selected."
  fi
}

function use_commit() {
  echo
  echo "$(c_green "Do you want to commit files above?") (Y/n)"
  read -r CONFIRM_CONFIRM
  if [ "$CONFIRM_CONFIRM" = "y" ] || [ -z "$CONFIRM_CONFIRM" ]; then
    git_commit
  else
    echo "Okay, you can commit later."
  fi
}

alias gic='git_commit'
function git_commit() {
  echo -e "$(c_green "? Commit name")"
  read -r COMMIT_NAME
  echo
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
  echo
  echo "$(c_green "Do you want to push now?") (Y/n)?"
  read -r CONFIRM_PUSH
  if [ "$CONFIRM_PUSH" = "y" ] || [ -z "$CONFIRM_PUSH" ]; then
    git push
    create_or_open_pr
  else
    echo "Okay, you can push later."
  fi
}

function create_or_open_pr() {
  echo
  echo "$(c_green "Do you want to create/open a pull request?") ( [end] / c: create / o: open)"
  read -r CREATE_PR
  if [ "$CREATE_PR" = "c" ]; then
    create_pr
  elif [ "$CREATE_PR" = "o" ]; then
    open_pr
  else
    echo "Okay, you can create/open a pull request later."
  fi
}

function create_pr() {
  current_branch=$(git branch | grep \* | cut -d ' ' -f2)
  gh pr create --base=main --head="$current_branch"
  open_pr
}

alias ghb='open_pr'
function open_pr() {
  select_pr=$(gh pr list --state=open | fzf --preview='echo {}')
  pr_number=$(echo "$select_pr" | awk '{print $1}')
  open "$(gh pr view "$pr_number" --web)"
}
