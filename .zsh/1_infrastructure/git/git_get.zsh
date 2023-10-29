function get_pr_number() {
	PR_LIST=$(gh pr list --state=open | fzf --preview='echo {}')

	if [[ -n $PR_LIST ]]; then
		PR_NUMBER=$(echo "$PR_LIST" | awk '{print $1}')
		echo "$PR_NUMBER"
	else
		return
	fi
}

function get_owner_and_repo() {
	OWNER_AND_REPO=$(gh repo view | awk 'NR==1 {print $2}')
	echo "$OWNER_AND_REPO"
}
