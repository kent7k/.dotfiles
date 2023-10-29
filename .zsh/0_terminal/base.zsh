BOLD=$(tput bold)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NORMAL=$(tput sgr0)
RED=$(tput setaf 1)

echo_section() {
	printf "\n%s%s► %s%s\n%s-----------------------------------------------%s\n" "${BOLD}" "${GREEN}" "$1" "${NORMAL}" "${YELLOW}" "${NORMAL}"
}
