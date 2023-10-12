# Sets GitHub CLI setting for completion
eval "$(gh completion -s zsh)"

# Makes git auto completion faster favouring for local completions
__git_files() {
  _wanted files expl 'local files' _files
}

# Opens the project repository in browser
# alias ghb='gh browse'

# Makes git logs more readable
alias gitlog="ghq list | fzf --preview "git --git-dir $(ghq root)/{}/.git log --date=short --pretty=format:'-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --color""

# Makes git more easy to command
# TODO: Makes workflows or Moves to navi, or Uses Fig.
alias gist='git status'
alias gilo='git log --oneline --graph'
alias girl='git reflog'

# Creates a new repository.
alias ghcr='ghcr'
function ghcr() {
  echo "What's the repository's name?" &&
    read argv
  echo "Please, write the description" &&
    read Description
  gh repo create "$argv" --private -d "$Description"
  mkdir "$argv"
  cd "$argv"
  echo "# $argv[1]" >>README.md
  git init
  git add README.md
  git commit -m "Initial commit"
  git branch -M main
  git remote add origin git@github.com:kent7k/$argv[1].git
  git remote add origin
  git push -u origin main
}




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
