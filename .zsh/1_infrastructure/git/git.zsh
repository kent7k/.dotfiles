# Makes git logs more readable
alias gitlog="ghq list | fzf --preview "git --git-dir $(ghq root)/{}/.git log --date=short --pretty=format:'-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --color""

alias gist='git status -s'
alias gistl='git status --long'
alias gilo='git log --oneline --graph'
alias girl='git reflog'
alias giba='git branch -a'

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
  git remote add origin git@github.com:$"GIT_AUTHOR_NAME"/"$REPO"[1].git
  git remote add origin
  git push -u origin main
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
  git remote add origin git@github.com:"$GIT_AUTHOR_NAME"/"$REPO".git
  git remote add origin
  git push -u origin main
}
