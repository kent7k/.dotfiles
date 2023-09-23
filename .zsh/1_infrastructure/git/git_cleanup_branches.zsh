function cleanupBranches() {
  # Ensure that we're inside a git directory
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not inside a git repository. Exiting."
    return 1
  fi

  # Helper function to prompt user
  prompt_user() {
    local message="$1"
    echo -n "$message (y/N): "
    read yn
    [[ $yn =~ [yY] ]]
  }

  # Delete remote-tracking branches that are no longer on the remote
  git fetch --prune --dry-run
  if prompt_user "Delete remote-tracking branches listed above?"; then
    git fetch --prune

    # --- Response ------------------------------------------
    #  From github.com:Organization/repository
    #  - [deleted]         (none)     -> origin/topic/add_basic_calendar
    #  - [deleted]         (none)     -> origin/topic/add_basic_text
    # ------------------------------------------------------

  else
    echo "Aborted deleting remote-tracking branches."
  fi

  # Delete local branches that have been merged
  merged_branches=$(git branch --merged | grep -vE '^\*|main|master|develop')
  if [ -z "$merged_branches" ]; then
    echo "No merged local branches to delete."
  else
    echo "Merged local branches to delete:"
    echo "$merged_branches"
    if prompt_user "Delete the merged local branches listed above?"; then
      echo "$merged_branches" | xargs git branch -d

      # --- Response ------------------------------------------
      # Deleted branch topic/create_basic_Icon_component (was 26b539e).
      # Deleted branch topic/create_basic_Modal_component (was 26b539e).
      # ------------------------------------------------------

    else
      echo "Aborted deleting merged local branches."
    fi
  fi
}
