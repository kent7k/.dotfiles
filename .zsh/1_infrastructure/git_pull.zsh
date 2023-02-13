alias gifm='git_fetch_merge'
function git_fetch_merge() {
  echo
  c_green "Do you want to merge main to current branch now?"
  echo "$(c_green "? Branch") ([main]/d:develop/@:end)"
  read -r MERGED_BRANCH
  if [ -z "$MERGED_BRANCH" ]; then
    MERGED_BRANCH="main"
    git fetch origin main
  elif [ "$MERGED_BRANCH" = "d" ]; then
    MERGED_BRANCH="develop"
    git fetch origin develop
  else
    echo "Okay, you can fetch later."
    echo
    return
  fi

  call_current_branch

  git diff "$CURRENT_BRANCH" origin/"$MERGED_BRANCH"
  printf "\n%s\n" "$(c_green "Do you want to merge main to current branch now?") (y/N)"
  read -r CONFIRM_MERGE
  if [ "$CONFIRM_MERGE" = "y" ]; then
    git merge origin/"$MERGED_BRANCH"
  else
    echo "Okay, you can merge later."
  fi

  git status --long

}
