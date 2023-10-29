function swift_format() {
	git diff --name-only origin/develop |
		grep swift |
		while read l; do
			/opt/homebrew/bin/swiftformat --config "$HOME/.dotfiles/.lint/.swiftformat" "$l"
		done
}
