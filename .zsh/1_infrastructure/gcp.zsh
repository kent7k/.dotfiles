# Changes to the other project.
alias chp='change_project'
function change_project() {
	gcloud config configurations activate \
		"$(gcloud config configurations list | awk '{print $1}' | grep -v NAME | fzf)" &&
		echo "" &&
		gcloud config list
}
