function switchToMain() {
  # Helper function to print messages in color
  function coloredEcho() {
    local color="$1"
    shift
    echo -e "\033[${color}m\n$@\033[0m" # Add \n before $@
  }

  # Ensure that we're in a git directory
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    coloredEcho "31" "Not inside a git repository. Exiting." # Red color
    return 1
  fi

  # Check for changes to tracked files and untracked files
  tracked_changes=$(git diff --name-only)
  untracked_changes=$(git ls-files --exclude-standard --others)

  if [ -z "$tracked_changes" ] && [ -z "$untracked_changes" ]; then
    coloredEcho "32" "No changes detected." # Green color
  else
    # Display changes and ask for confirmation to stash
    if [ ! -z "$tracked_changes" ]; then
      coloredEcho "33" "Detected changes to tracked files:" # Yellow color
      echo "$tracked_changes"
    fi
    if [ ! -z "$untracked_changes" ]; then
      coloredEcho "33" "Detected untracked files:" # Yellow color
      echo "$untracked_changes"
    fi

    coloredEcho "36" "Note:"
    coloredEcho "36" "By default, only changes to tracked files will be stashed. Untracked files will not be included."                     # Cyan color
    coloredEcho "36" "If you want to stash untracked files as well, you can manually use: \033[1mgit stash save --include-untracked\033[0m" # Cyan color for the message and bold for the command
    print -n "Do you want to stash the tracked changes? (y/N): "
    read yn

    case $yn in
      [Yy]*)
        git stash
        ;;
      *)
        coloredEcho "31" "Not stashing changes. Exiting." # Red color
        return 0
        ;;
    esac
  fi

  # Switch to the main branch and rebase
  git checkout main
  git pull --rebase # Optionally pull the latest changes from upstream

  # Check if there's a stash to pop
  if git stash list | grep -q 'stash@{0}'; then
    # Show the changes in the most recent stash
    coloredEcho "36" "Changes in the most recent stash:" # Cyan color
    git stash show

    # Ask for confirmation to pop the stash
    print -n "Do you want to pop the most recent stash on the main branch? (y/N): "
    read yn

    case $yn in
      [Yy]*)
        # Use git stash pop and redirect its output to /dev/null to suppress its verbose messages
        # This way, only the subsequent git status -s output will be visible
        git stash pop >/dev/null

        # ---------------------------- verbose messages -------------------------------
        #
        #        ❯ git stash pop
        #        On branch main
        #        Your branch is up to date with 'origin/main'.
        #
        #        Changes not staged for commit:
        #          (use "git add <file>..." to update what will be committed)
        #          (use "git restore <file>..." to discard changes in working directory)
        #                modified:   .bash/.bashrc
        #                modified:   .zsh/.zshrc
        #                modified:   navi/git/git_check_branch.cheat
        #
        #        Untracked files:
        #          (use "git add <file>..." to include in what will be committed)
        #                .zsh/0_terminal/gitstash.zsh
        #                .zsh/2_languages/python/
        #                .zsh/4_routine/secs.zsh
        #                Theme/
        #
        #        no changes added to commit (use "git add" and/or "git commit -a")
        #        Dropped refs/stash@{0} (b13cea9ddfa9671afe01fc49169417816f0120ea)
        #
        # ------------------------------------------------------------------------------

        coloredEcho "36" "Current status after popping the stash:" # Cyan color
        git status -s

        ;;
      *)
        coloredEcho "34" "Not popping the stash. Done." # Blue color
        ;;
    esac
  else
    coloredEcho "32" "No stash to pop. Done." # Green color
  fi
}
