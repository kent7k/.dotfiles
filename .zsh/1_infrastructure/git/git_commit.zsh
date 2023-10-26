BOLD=$(tput bold)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
NORMAL=$(tput sgr0)

echo_section() {
    printf "\n%s%s► %s%s\n%s-----------------------------------------------%s\n" "${BOLD}" "${GREEN}" "$1" "${NORMAL}" "${YELLOW}" "${NORMAL}"
}

alias gha='git_add'
function git_add() {
  echo_section "Adding Selected Files"

  # Fetch files and their statuses, but exclude untracked files
  local files_and_status=$(git status --short | grep -v '^??' | fzf --multi)

  if [ -n "$files_and_status" ]; then
    printf "${LIGHT_GRAY}Added files:%s\n" "${NORMAL}"
    while IFS= read -r line; do
      # Split the file_status and filename
      local file_status="${line:0:2}"
      local file="${line:3}"

      git add "$file"
      # Show both the file_status and filename
      echo -e "${CYAN}  $file_status $file${NORMAL}"
    done <<<"$files_and_status"

    use_commit
  else
    echo "No files selected."
  fi
}

alias ghau='git_add_untracked_files'
function git_add_untracked_files() {
    echo_section "Adding Untracked Files"

  # Fetch untracked files using git ls-files
  local added_untracked_files=$(git ls-files --others --exclude-standard | fzf --multi)

  if [ -n "$added_untracked_files" ]; then
    printf "${LIGHT_GRAY}Added untracked files:%s\n" "${NORMAL}"
    while IFS= read -r file; do
      git add "$file"
      echo -e "${CYAN}  - $file${NORMAL}"
    done <<<"$added_untracked_files"

    use_commit
  else
    echo "No files selected."
  fi
}

function use_commit() {
  echo_section "Committing Selected Files"

  printf "\n%sDo you want to commit files above?%s (Y/n)\n" "${GREEN}" "${NORMAL}"

  read -r CONFIRM_CONFIRM
  if [ "$CONFIRM_CONFIRM" = "y" ] || [ -z "$CONFIRM_CONFIRM" ]; then
    git_commit
  else
    echo "Okay, you can commit later."
  fi
}

alias ghc='git_commit'
function git_commit() {
    if [ -f "./.envrc" ]; then
        source "./.envrc"
    fi

    # If GIT_COMMIT_NAME doesn't exist (wasn't exported), set a default value
    if [ -z "${GIT_COMMIT_NAME}" ]; then
        echo 'export GIT_COMMIT_NAME="Default Commit Message"' >> ./.envrc
        export GIT_COMMIT_NAME="Default Commit Message"
    fi

    echo_section "Committing Changes as $GIT_COMMIT_NAME"

    # Get today's date and calculate the difference in days
    TODAY_DATE=$(date +"%Y-%m-%d")
    if [ ! -z "$GIT_COMMIT_DATE" ]; then
        DATE_DIFF=$(( ( $(date -jf "%Y-%m-%d" "$TODAY_DATE" +%s) - $(date -jf "%Y-%m-%d" "$GIT_COMMIT_DATE" +%s) ) / 86400 ))
        echo "Days since last commit: $DATE_DIFF days"
    else
        DATE_DIFF=0
    fi

    # Prompt the user to enter a new commit name or use the default one
    printf "\n%s? Type a commit name (or press Enter to use the default)" "${GREEN}" "${NORMAL}"

    read -r TYPED_COMMIT_NAME

    # If the user typed something, update GIT_COMMIT_NAME
    if [ ! -z "$TYPED_COMMIT_NAME" ]; then
        COMMIT_NAME="$TYPED_COMMIT_NAME"
        if grep -q "export GIT_COMMIT_NAME=" "./.envrc"; then
            sed -i "" "s/^export GIT_COMMIT_NAME=.*/export GIT_COMMIT_NAME=\"$TYPED_COMMIT_NAME\"/" "./.envrc"
        else
            echo "export GIT_COMMIT_NAME=\"$TYPED_COMMIT_NAME\"" >> ./.envrc
        fi
    else
        COMMIT_NAME="$GIT_COMMIT_NAME"
    fi

    # Update or append GIT_COMMIT_DATE
    if grep -q "export GIT_COMMIT_DATE=" "./.envrc"; then
        sed -i "" "s/^export GIT_COMMIT_DATE=.*/export GIT_COMMIT_DATE=\"$TODAY_DATE\"/" "./.envrc"
    else
        echo "export GIT_COMMIT_DATE=\"$TODAY_DATE\"" >> ./.envrc
    fi

    echo ".envrc has been updated."

    # Display the chosen commit name
    echo "Using commit name: $COMMIT_NAME"

  printf "\n%sDo you want to use --no-verify option?%s (Y/n)\n" "${GREEN}" "${NORMAL}"

  read -r VERIFY
  if [ "$VERIFY" = "y" ] || [ -z "$VERIFY" ]; then
    git commit -m "$COMMIT_NAME" --no-verify
  else
    git commit -m "$COMMIT_NAME"
  fi

  git_push
}

function git_push() {
  echo_section "Pushing Changes"

  printf "\n%sDo you want to push now?%s (Y/n)?\n" "${GREEN}" "${NORMAL}"

  read -r CONFIRM_PUSH
  if [ "$CONFIRM_PUSH" = "y" ] || [ -z "$CONFIRM_PUSH" ]; then
    git push
    create_or_open_pr
  else
    echo "Okay, you can push later."
  fi
}

function create_or_open_pr() {
  echo_section "Managing Pull Requests"

  printf "\n%sDo you want to create/open a pull request?%s ( [end] / c: create / o: open)\n" "${GREEN}" "${NORMAL}"

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
  echo_section "Force Pushing Changes"

  printf "\n%sDo you want to force push now?%s (Y/n)?\n" "${GREEN}" "${NORMAL}"
  read -r CONFIRM_FORCE_PUSH
  if [ "$CONFIRM_FORCE_PUSH" = "y" ] || [ -z "$CONFIRM_FORCE_PUSH" ]; then
    git push --force-with-lease
  else
    echo "Okay, you can push later."
  fi
}
