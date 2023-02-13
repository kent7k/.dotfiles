alias gisq='git_squash'

function git_squash() {
  call_current_branch

  # Check if there are uncommitted changes in the current branch
  if [ -n "$(git status --porcelain)" ]; then
    git stash
  fi

  access_main_or_develop_by "git checkout"

  git merge --squash "$CURRENT_BRANCH"
  git fetch origin main

  if [ -n "$(git stash list)" ]; then
    git stash pop
  fi
}
