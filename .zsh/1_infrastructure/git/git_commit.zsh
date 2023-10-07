alias gip='git push'
alias gipu='git pull'

alias gia='git_add'
function git_add() {
  echo
  added_files=$(git diff --name-only | fzf --multi)
  if [ -n "$added_files" ]; then
    echo -e "$(c_light_gray "Added file:")"
    while read -r file; do
      git add "$file"
      echo -e "$(c_cyan "  - $file")"
    done <<<"$added_files"

    use_commit
  else
    echo "No files selected."
  fi
}

alias giau='git_add_untracked_files'
function git_add_untracked_files() {
  echo
  added_untracked_files=$(git ls-files --others --exclude-standard | fzf --multi)
  if [ -n "$added_untracked_files" ]; then
    echo -e "$(c_light_gray "Added untracked file:")"
    while IFS= read -r file; do
      git add "$file"
      echo -e "$(c_cyan "  - $file")"
    done <<<"$added_untracked_files"

    use_commit
  else
    echo "No files selected."
  fi
}

function use_commit() {
  printf "\n%s\n" "$(c_green "Do you want to commit files above?") (Y/n)"
  read -r CONFIRM_CONFIRM
  if [ "$CONFIRM_CONFIRM" = "y" ] || [ -z "$CONFIRM_CONFIRM" ]; then
    git_commit
  else
    echo "Okay, you can commit later."
  fi
}

alias gic='git_commit'
function git_commit() {
    # Load .env file if it exists
    if [ -f "./.env" ]; then
        source "./.env"
    fi

    # Check if GIT_COMMIT_NAME exists in .env, if not, set a default value
    if ! grep -q "GIT_COMMIT_NAME=" "./.env"; then
        echo "GIT_COMMIT_NAME=\"Default Commit Message\"" >> ./.env
    fi

    # Display the default commit name from .env
    echo "Default commit name from .env is: $GIT_COMMIT_NAME"

    # Get today's date and calculate the difference in days
    TODAY_DATE=$(date +"%Y-%m-%d")
    if [ ! -z "$GIT_COMMIT_DATE" ]; then
        DATE_DIFF=$(( ( $(date -jf "%Y-%m-%d" "$TODAY_DATE" +%s) - $(date -jf "%Y-%m-%d" "$GIT_COMMIT_DATE" +%s) ) / 86400 ))
        echo "Days since last commit: $DATE_DIFF days"
    else
        DATE_DIFF=0
    fi

    # Prompt the user to enter a new commit name or use the default one
    echo -e "$(c_green "? Type a commit name (or press Enter to use the default)")"
    read -r TYPED_COMMIT_NAME

    # If the user typed something, update GIT_COMMIT_NAME
    if [ ! -z "$TYPED_COMMIT_NAME" ]; then
        COMMIT_NAME="$TYPED_COMMIT_NAME"
        if grep -q "GIT_COMMIT_NAME=" "./.env"; then
            sed -i "" "s/^GIT_COMMIT_NAME=.*/GIT_COMMIT_NAME=\"$TYPED_COMMIT_NAME\"/" "./.env"
        else
            echo "GIT_COMMIT_NAME=\"$TYPED_COMMIT_NAME\"" >> ./.env
        fi
    else
        COMMIT_NAME="$GIT_COMMIT_NAME"
    fi

    # Update or append GIT_COMMIT_DATE
    if grep -q "GIT_COMMIT_DATE=" "./.env"; then
        sed -i "" "s/^GIT_COMMIT_DATE=.*/GIT_COMMIT_DATE=\"$TODAY_DATE\"/" "./.env"
    else
        echo "GIT_COMMIT_DATE=\"$TODAY_DATE\"" >> ./.env
    fi

    echo ".env has been updated."

    # Display the chosen commit name
    echo "Using commit name: $COMMIT_NAME"

  printf "\n%s\n" "$(c_green "Do you want to use --no-verify option?") (Y/n)"
  read -r VERIFY
  if [ "$VERIFY" = "y" ] || [ -z "$VERIFY" ]; then
    git commit -m "$COMMIT_NAME" --no-verify
  else
    git commit -m "$COMMIT_NAME"
  fi


  git_push
}

function git_push() {
  printf "\n%s\n" "$(c_green "Do you want to push now?") (Y/n)?"
  read -r CONFIRM_PUSH
  if [ "$CONFIRM_PUSH" = "y" ] || [ -z "$CONFIRM_PUSH" ]; then
    git push
    create_or_open_pr
  else
    echo "Okay, you can push later."
  fi
}

function create_or_open_pr() {
  printf "\n%s\n" "$(c_green "Do you want to create/open a pull request?") ( [end] / c: create / o: open)"
  read -r -t 10 CREATE_PR
  if [ -z "$CREATE_PR" ]; then
    echo "Timeout exceeded. You can create/open a pull request later."
  elif [ "$CREATE_PR" = "c" ]; then
    create_pr
  elif [ "$CREATE_PR" = "o" ]; then
    open_pr
  else
    echo "Okay, you can create/open a pull request later."
  fi
}

function create_pr() {
  CURRENT_BRANCH=$(call_current_branch)
  gh pr create --base=main --head="$CURRENT_BRANCH"
  sleep 1
  open_pr
}

alias ghb='open_pr'
function open_pr() {
  PR_NAMBER=$(get_pr_number)
  if [[ -n $PR_NAMBER ]]; then
    open "$(gh pr view "$pr_number" --web)"
  else
    OWNER_AND_REPO=$(get_owner_and_repo)
    open "https://github.com/${OWNER_AND_REPO}"
  fi
}

function git_force_push() { #---------- Other files are related to this function ----------#
  printf "\n%s\n" "$(c_green "Do you want to force push now?") (Y/n)?"
  read -r CONFIRM_FORCE_PUSH
  if [ "$CONFIRM_FORCE_PUSH" = "y" ] || [ -z "$CONFIRM_FORCE_PUSH" ]; then
    git push --force-with-lease
  else
    echo "Okay, you can push later."
  fi
}
