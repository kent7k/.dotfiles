alias gifm='git_fetch_merge'
function git_fetch_merge() {
  echo
  call_current_branch

  c_green "? Branch to merge"
  access_main_or_develop_by "git fetch origin"
  # shellcheck disable=SC2154
  git merge "$target"
  git status
  git diff "$CURRENT_BRANCH" origin/"$target"
  printf "\n%s\n" "$(c_green "Do you want to merge main to current branch now?") (y/N)"
  read -r CONFIRM_MERGE
  if [ "$CONFIRM_MERGE" = "y" ]; then
    git merge origin/"$target"
  else
    echo "Okay, you can merge later."
  fi

  git status --long
}
