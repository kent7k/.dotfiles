alias mva='moveAllToTarget'

function moveAllToTarget() {
	local target_dir target_cleaned choice

	if [[ -n "$1" ]]; then
		target_dir="./$1"
	else
		target_dir=$(find . -maxdepth 1 -type d ! -name '.' | fzf --prompt="Select the target directory: ")
	fi

	if [[ -z "$target_dir" ]]; then
		echo "No directory selected. Operation cancelled."
		return 1
	fi

	target_cleaned=${target_dir#./}

	if [[ -z "$1" ]]; then
		read "confirmation?Are you sure you want to move items into '$target_cleaned'? (y/n) "
		if [[ "$confirmation" != "y" ]]; then
			echo "Operation cancelled."
			return 1
		fi
	fi

	if [[ -z "$2" ]]; then
		echo "Do you want to move:"
		echo "1 or onlyDirectories: Only directories"
		echo "2 or All: Both directories and files"
		echo "3 or onlyFiles: Only files"
		read "choice?Enter your choice: "
	else
		choice="$2"
	fi

	case $choice in
	1 | onlyDirectories)
		find . -maxdepth 1 -type d ! -name '.' ! -name "$target_cleaned" -exec mv {} "$target_cleaned"/ \;
		;;
	2 | All)
		find . -maxdepth 1 ! -name '.' ! -name "$target_cleaned" -exec mv {} "$target_cleaned"/ \;
		;;
	3 | onlyFiles)
		find . -maxdepth 1 -type f -exec mv {} "$target_cleaned"/ \;
		;;
	*)
		echo "Invalid selection."
		;;
	esac

	echo "Operation completed."
}
