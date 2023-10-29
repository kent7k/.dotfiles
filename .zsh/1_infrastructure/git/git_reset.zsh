#!/opt/homebrew/bin/zsh
# Git Status Reference:
# ======================
#
# Staging area (first column):
# ---------------------------
# ` ` (space): File is unchanged (not staged).
# A: File is added.
# M: File is modified.
# D: File is deleted.
# R: File is renamed.
# C: File is copied.
#
# Working directory (second column):
# ---------------------------------
# ` ` (space): File is unchanged (not modified in the working directory since the index).
# M: File is modified in the working directory but not staged.
# D: File is deleted in the working directory but not staged.
# A: File is added to the working directory but not staged.
# R: File is renamed in the working directory but not staged.
# C: File is copied in the working directory but not staged.
# ?: File is not tracked by Git.
# !: File is ignored.

alias ghars="git_unstage"
function git_unstage() {
	local entries
	local selected

	# Extract the files under "Changes to be committed" with their status, formatted as per your request
	entries=$(git status --porcelain | grep '^[MADR]' | awk '{
      if ($1 == "D") print $2 "  (deleted)";
      else if ($1 == "M") print $2;
      else if ($1 == "A") print $2 "  (added)";
      else if ($1 == "R") print $2 "  (renamed)";
      else if ($1 == "C") print $2 "  (copied)";
      # You can add other statuses here as needed
      Staging area (first column):

  }')

	# Check if there are any entries to be shown
	if [ -z "$entries" ]; then
		echo "No files to unstage!"
		return
	fi

	# Use fzf to select an entry
	selected=$(echo "$entries" | fzf --height 30% --reverse --multi | awk '{gsub(/  \(.*\)$/, "", $0); print}')

	# Check if an entry was selected
	if [ -n "$selected" ]; then
		# Use git restore to unstage the selected files
		git restore --staged $selected
	else
		echo "No file selected!"
	fi

	git status --short
}

alias gire='git_reset'
function git_reset() {
	printf "\n%sDo you want to reset repository?%s (y/N)\n" "${GREEN}" "${NORMAL}"
	read -r CONFIRM_RESET
	if [ "$CONFIRM_RESET" = "y" ]; then
		printf "  %s1: Return back 'add' (=Unstage everything)%s\n" "${GREEN}" "${NORMAL}"
		printf "  %s2: Return back 'added specific file'%s\n" "${GREEN}" "${NORMAL}"
		printf "  %s3: Return back 'commit'%s\n" "${GREEN}" "${NORMAL}"
		printf "  %s4: Reset 'any uncommitted changes, staged or not  (for only unstaged changes)'%s\n" "${GREEN}" "${NORMAL}"
		printf "  %s5: Reset 'add, commit, change'%s\n" "${GREEN}" "${NORMAL}"

		read -r RESET_TYPE
		case "$RESET_TYPE" in
		[1]) git reset ;;
		[2]) git reset --patch path/to/file ;;
		[3]) git reset --soft HEAD~ ;;
		[4]) git reset --hard ;;
		[5]) git reset --hard HEAD~ ;;
		*) echo "Push number key." ;;
		esac
	else
		echo "Okay, you can reset repository later."
	fi
}

function git_clean_untracked_files() {
	# FIXME
	printf "\n%sDo you want to clean files?%s\n" "${GREEN}"
	git clean -i
}

function reset_repository_commit_log() {
	echo
	printf "%s[ WARNING ]%s\n" "${RED}" "${NORMAL}"
	printf "%sDo you want to reset commit log?%s (yes/N)\n" "${RED}" "${NORMAL}"
	read -r CONFIRM_RESET_COMMIT
	if [ "$CONFIRM_RESET_COMMIT" = "yes" ]; then
		git checkout --orphan latest_branch
		git add -A
		git commit -am "commit message"
		git branch -D main
		git branch -m main
		git push -f origin main
	else
		echo "Okay, you can reset commit log later."
	fi
}
