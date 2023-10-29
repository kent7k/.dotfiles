BOLD=$(tput bold)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)

echo_section() {
	local second_white_message=""
	if [ -n "$2" ]; then
		second_white_message=" ($2 days ago)"
	fi
	printf "\n%s%s► %s%s%s%s\n%s-----------------------------------------------%s\n" "${BOLD}" "${GREEN}" "$1" "${NORMAL}" "${NORMAL}" "$second_white_message" "${YELLOW}" "${NORMAL}"
}
