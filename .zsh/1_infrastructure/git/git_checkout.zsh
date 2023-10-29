alias ghch='git_checkout'
function git_checkout() {
	# High-level Overview:
	# 1. Attempt git checkout
	# 2. If there are unstashed changes preventing checkout:
	#    - Stash the changes
	#    - Attempt git checkout again
	#    - Decide to either pop the stash or discard it

	local branch
	local stashed_files
	local stash_msg

	# Fetch the list of branches that have not been merged
	branches=$(git branch --no-merged)

	# Count the branches
	branch_count=$(echo "$branches" | wc -l | tr -d ' ')

	# Inform the user of the branch count
	echo "Total branches: $branch_count"

	# Use fzf to select a branch
	branch=$(echo "$branches" | fzf +m --preview "echo {} | xargs -I {} git log --color=always --oneline --abbrev-commit -- {} | head -n 10" --preview-window=down:10:wrap)

	if [[ $branch ]]; then
		# Try to checkout the branch
		checkout_output=$(git checkout $(echo "$branch" | xargs) 2>&1)

		# If there's an error because of unstashed changes
		if [[ $checkout_output =~ "error: Your local changes to the following files would be overwritten by checkout:" ]]; then
			echo "$checkout_output"

			# Extract list of files that need stashing
			stashed_files=$(echo "$checkout_output" | awk '/error: Your local changes to the following files would be overwritten by checkout:/, /Please commit your changes or stash them/' | sed -e '1d' -e '$d' | tr -d '\t' | xargs)

			# Prompt user for a stash message
			echo -n "Enter stash message: "
			read stash_msg

			# Stash the changes with the provided message
			git stash push -m "$stash_msg" -- $stashed_files

			# Display a summary of what was stashed
			echo "Stashed changes summary:"
			git stash show stash@{0}

			# Show differences between stashed changes and the branch you're checking out
			echo "Differences between stashed changes and branch:"
			git diff stash@{0} $(echo "$branch" | xargs)

			# Now, try to checkout the branch again
			git checkout $(echo "$branch" | xargs)

			# Prompt user for what to do with the stashed changes
			while true; do
				echo "Do you want to [p]op the stash or [t]rash it? [p/t]: "
				read action

				case $action in
				p | P)
					git stash pop
					break
					;;
				d | D)
					git stash drop stash@{0}
					echo "Stashed changes discarded."
					break
					;;
				*)
					echo "Invalid choice. Please choose 'p' to pop or 't' to drop."
					;;
				esac
			done
		fi
	fi
}

alias ghchb='git_checkout_b'
function git_checkout_b() {
	local branch_name

	# Prompt the user for the branch name
	read "?Enter the branch name to checkout: " branch_name

	# Check out to the given branch name
	git checkout -b $branch_name
}
