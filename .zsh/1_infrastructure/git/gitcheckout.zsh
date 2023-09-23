function createNewBranch() {
  # Helper function to print messages in color
  function coloredEcho() {
    local color="$1"
    shift
    shift
    echo -e "\033[${color}m$@\033[0m"
  }

  # Ensure that we're in a git directory
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    coloredEcho "31" "Not inside a git repository. Exiting." # Red color
    return 1
  fi

  # Check if we're on the main branch
  current_branch=$(git rev-parse --abbrev-ref HEAD)
  if [ "$current_branch" != "main" ]; then
    coloredEcho "31" "You are not on the main branch. Current branch: $current_branch. Exiting." # Red color
    return 1
  fi

  while true; do
    # Prompt the user for the new branch name
    print -n "Enter the name for the new branch: "
    read new_branch_name

    # Check if the branch name is empty
    if [ -z "$new_branch_name" ]; then
      coloredEcho "31" "Branch name cannot be empty. Please provide a valid name."
      continue
    fi

    # Check if the branch already exists
    if git show-ref --verify --quiet refs/heads/$new_branch_name; then
      coloredEcho "31" "Branch already exists. Please provide a different name."
      continue
    else
      break
    fi
  done

  # Create and checkout the new branch
  git checkout -b $new_branch_name
  coloredEcho "32" "Switched to a new branch: $new_branch_name" # Green color

  git status -s
}
