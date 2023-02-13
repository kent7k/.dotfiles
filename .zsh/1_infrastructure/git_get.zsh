function get_pr_number() {
  PR_NAMBER=$(gh pr list --state=open | fzf --preview='echo {}')

  if [[ -n $PR_NAMBER ]]; then
    pr_number=$(echo "$PR_NAMBER" | awk '{print $1}')
    echo "$pr_number"
  else
    return
  fi
}

function get_owner_and_repo() {
  # shellcheck disable=SC2034
  OWNER_AND_REPO=$(gh repo view | awk 'NR==1 {print $2}')
}
