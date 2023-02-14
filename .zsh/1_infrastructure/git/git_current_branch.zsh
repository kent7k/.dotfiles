function call_current_branch() {
  CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
  echo "$CURRENT_BRANCH"
}
