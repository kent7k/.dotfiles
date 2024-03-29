alias gisq='git_squash'

function git_squash() {
	CURRENT_BRANCH=$(call_current_branch)

	# Check if there are uncommitted changes in the current branch
	if [ -n "$(git status --porcelain)" ]; then
		git stash
	fi

	git_checkout_main_or_develop

	git merge --squash "$CURRENT_BRANCH"
	git fetch origin main

	#  if [ -n "$(git stash list)" ]; then
	#    git stash pop
	#  fi
}
