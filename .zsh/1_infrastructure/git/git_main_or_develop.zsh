function access_main_or_develop_by() {
	printf "%s? Branch%s ([main]/d:develop)\n" "${GREEN}" "${NORMAL}"
	read -r -s user_input
	target="main"
	case $user_input in
	"m") target="main" ;;
	"d") target="develop" ;;
	esac
	"$1" "$target"
}

# FIXME: This function is alternative to access_main_or_develop_by().
function git_checkout_main_or_develop() {
	printf "%s? Branch%s ([main]/d:develop)\n" "${GREEN}" "${NORMAL}"
	read -r -s user_input
	target="main"
	case $user_input in
	"m") target="main" ;;
	"d") target="develop" ;;
	esac
	git checkout "$target"
}
