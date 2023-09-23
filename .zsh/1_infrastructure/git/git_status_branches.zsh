function statusBranches() {
  git branch -v | awk -f "$DOT_FILES/.zsh/1_infrastructure/git/git_status_branches.awk"
}
