# Makes git logs more readable
alias gitlog="ghq list | fzf --preview "git --git-dir $(ghq root)/{}/.git log --date=short --pretty=format:'-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --color""

# Makes git more easy to command

alias gist='git status -s'
alias gistl='git status --long'
alias gilo='git log --oneline --graph'
alias girl='git reflog'
alias giba='git branch -a'

# Pushes to the develop branch.
gipm() {
  read -r -p "Which branch do you want to merge? (main or develop) " branch
  if [ -z "$branch" ]; then
    git pull origin main
  else
    git pull origin develop
  fi

  read -r -p "Type the branch name to merge: " branch_to_merge
  git merge "$branch_to_merge"

  git status
  read -r -p "Is it okay to continue? (yes or no) " answer
  if [ "$answer" = "yes" ]; then
    if [ "$branch" = "main" ]; then
      git push origin main
    else
      git push origin develop
    fi
  fi
}

# Creates a new repository.
GH_USERNAME='kent7k'
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
  git remote add origin git@github.com:$GH_USERNAME/"$REPO".git
  git remote add origin
  git push -u origin main
}

alias gire='git_reset'
function git_reset() {
  echo
  echo "$(c_green "Do you want to reset repository?") (y/N)"
  read -r CONFIRM_RESET
  if [ "$CONFIRM_RESET" = "y" ]; then
    echo -e "$(c_green "  1: Return back 'add' (=Unstage everything)")"
    echo -e "$(c_green "  2: Return back 'added specific file'")"
    echo -e "$(c_green "  3: Return back 'commit'")"
    echo -e "$(c_green "  4: Reset 'any uncommitted changes, staged or not  (for only unstaged changes)'")"
    echo -e "$(c_green "  5: Reset 'add, commit, change'")"
    read -r RESET_TYPE
    case "$RESET_TYPE" in
      [1]) git reset ;;
      [2]) git reset --patch path/to/file ;;
      [3]) git reset --soft HEAD~ ;;
      [4]) git reset --hard ;;
      [5]) git reset --hard HEAD~ ;;
      *) echo "Push number key." ;;
    esac
  else
    echo "Okay, you can reset repository later."
  fi
}

function git_clean_untracked_files() {
  git clean -dn
  echo
  echo "$(c_green "Do you want to clean files above?") (y/N)"
  read -r CONFIRM_CLEAN
  if [ "$CONFIRM_CLEAN" = "y" ]; then
    git clean -df
  else
    echo "Okay, you can clean files later."
  fi
}

function reset_repository_commit_log() {
  echo
  c_red "[ WARNING ]"
  echo "$(c_red "Do you want to reset commit log?") (yes/N)"
  read -r CONFIRM_RESET_COMMIT
  if [ "$CONFIRM_RESET_COMMIT" = "yes" ]; then
    git checkout --orphan latest_branch
    git add -A
    git commit -am "commit message"
    git branch -D main
    git branch -m main
    git push -f origin main
  else
    echo "Okay, you can reset commit log later."
  fi
}
