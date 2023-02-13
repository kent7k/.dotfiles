# Makes git logs more readable
alias gitlog="ghq list | fzf --preview "git --git-dir $(ghq root)/{}/.git log --date=short --pretty=format:'-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --color""

# Makes git more easy to command

alias gist='git status -s'
alias gilo='git log --oneline --graph'
alias girl='git reflog'
alias giba='git branch -a'

# Pushes to the develop branch.
gmpd() {
  git pull origin develop
  echo "Type the branch name to merge : " && read branch
  git merge "${branch}"
  git status
  echo "Is it okay to continue?" && read
  git push origin develop
}

# Creates a new repository.
alias ghcr='create_repository'
function create_repository() {
  echo -e "$(c_green "? Repository")" &&
    read -r REPO
  echo -e "$(c_green "? Description")" &&
    read -r DESCRIPTION
  gh repo create "$REPO" --private -d "$DESCRIPTION"
  mkdir "$REPO"
  cd "$REPO" || return
  echo "# ${REPO[1]}" >>README.md
  git init
  git add README.md
  git commit -m "Initial commit"
  git branch -M main
  git remote add origin git@github.com:kent7k/"$REPO"[1].git
  git remote add origin
  git push -u origin main
}
