function call_current_branch() {
  # shellcheck disable=SC2034
  CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
}
