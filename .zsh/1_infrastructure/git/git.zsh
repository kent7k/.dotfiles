# Sets GitHub CLI setting for completion
eval "$(gh completion -s zsh)"

# Makes git auto completion faster favouring for local completions
__git_files() {
	_wanted files expl 'local files' _files
}

# Opens the project repository in browser
# alias ghb='gh browse'

# Makes git logs more readable
alias gitlog="ghq list | fzf --preview 'git --git-dir $(ghq root)/{}/.git log --date=short --pretty=format:\"-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset\" --color'"

# Makes git more easy to command
# TODO: Makes workflows or Moves to navi, or Uses Fig.
alias gist='git status'
alias gilo='git log --oneline --graph'
alias girl='git reflog'

alias ghcr='create_github_repo'

function create_github_repo() {
	echo_section "Repository Creation"

	# Prompt for repository name
	echo "${YELLOW}Enter the repository's name:${NORMAL}"
	read -r repo_name
	if [[ -z "$repo_name" ]]; then
		echo "${RED}Repository name is required.${NORMAL}"
		return 1
	fi

	# Prompt for description
	echo "${YELLOW}Enter the repository's description:${NORMAL}"
	read -r repo_description

	# Create the repository on GitHub
	if ! gh repo create "$repo_name" --private -d "$repo_description"; then
		echo "${RED}Failed to create the GitHub repository.${NORMAL}"
		return 1
	fi

	# Initialize the repository locally
	echo_section "Local Initialization"

	mkdir "$repo_name" && cd "$repo_name" || {
		echo "${RED}Failed to navigate to the new directory.${NORMAL}"
		return 1
	}

	# Setup README.md and push the initial commit
	echo "${YELLOW}Setting up README.md and pushing the initial commit...${NORMAL}"
	echo "# $repo_name" >README.md
	git init
	git add README.md
	git commit -m "Initial commit"
	git branch -M main
	git remote add origin git@github.com:kent7k/"$repo_name".git
	git push -u origin main
}

# Makes git logs more readable
alias gitlog="ghq list | fzf --preview "git --git-dir $(ghq root)/{}/.git log --date=short --pretty=format:'-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --color""

alias gist='git status -s'
alias gistl='git status --long'
alias gilo='git log --oneline --graph'
alias girl='git reflog'
alias giba='git branch -a'
