format_shell_files_in_pwd() {
	local tmp_file
	local decision

	# Create an empty array to store files needing format and changed files
	local -a files_needing_format=()
	local -a changed_files=()

	# Identify files that would be formatted
	find . -type f \( -name "*.sh" -o -name "*.zsh" \) -print0 | while IFS= read -r -d '' file; do
		tmp_file="$(mktemp)"
		shfmt <"$file" >"$tmp_file"
		if ! diff -q "$file" "$tmp_file" >/dev/null; then
			files_needing_format+=("$file")
		fi
		rm "$tmp_file"
	done

	# List files that would be formatted
	if ((${#files_needing_format[@]} > 0)); then
		echo_section "Files Needing Formatting"
		for f in "${files_needing_format[@]}"; do
			echo "  $f"
		done
	else
		echo_section "No files need formatting."
		return
	fi

	# Ask once if you want to format all the listed files
	echo
	echo "${YELLOW}Do you want to apply formatting to the above files?${NORMAL} (y/n)"
	read decision </dev/tty

	if [[ "$decision" == "y" ]]; then
		for file in "${files_needing_format[@]}"; do
			shfmt -w "$file"
			changed_files+=("$file")
		done
	fi

	# Print the changed files
	if ((${#changed_files[@]} > 0)); then
		echo_section "Files Formatted with shfmt"
		for f in "${changed_files[@]}"; do
			echo "  $f"
		done
	else
		echo_section "No files were changed after formatting with shfmt."
	fi
}
