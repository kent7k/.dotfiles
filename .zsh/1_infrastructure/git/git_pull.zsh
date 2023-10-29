alias gifm='git_fetch_merge'
function git_fetch_merge() {
	echo
	CURRENT_BRANCH=$(call_current_branch)

	printf "%s? Branch to merge%s\n" "${GREEN}" "${NORMAL}"
	access_main_or_develop_by "git fetch origin"
	# shellcheck disable=SC2154
	git merge "$target"
	git status
	git diff "$CURRENT_BRANCH" origin/"$target"
	printf "%sDo you want to merge main to current branch now?%s (y/N)\n" "${GREEN}" "${NORMAL}"
	read -r CONFIRM_MERGE
	if [ "$CONFIRM_MERGE" = "y" ]; then
		git merge origin/"$target"
	else
		echo "Okay, you can merge later."
	fi

	git status --long
}
