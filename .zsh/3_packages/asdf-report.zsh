# Makes version by asdf interactively.
BOLD=$(printf '\e[1m')
NORMAL=$(printf '\e[0m')
GREEN=$(printf '\e[32m')
YELLOW=$(printf '\e[33m')

function list_node_versions() {
  local versions=("20" "18" "16")
  local absolute_latest=$(asdf list-all nodejs | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$" | tail -n 1)

  printf "${BOLD}${GREEN}%-10s %-8s:${NORMAL}${YELLOW} " "Node.js" "$absolute_latest"

  for ver in "${versions[@]}"; do
    local version=$(asdf list-all nodejs | grep -E "^$ver\.[0-9]+\.[0-9]+$" | tail -n 1)
    printf "%-12s" "$version"
  done
  echo "${NORMAL}"
}

function list_python_versions() {
  local versions=("3.11" "3.10")
  local absolute_latest=$(asdf list-all python | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$" | tail -n 1)

  printf "${BOLD}${GREEN}%-10s %-8s:${NORMAL}${YELLOW} " "Python" "$absolute_latest"

  for ver in "${versions[@]}"; do
    local version=$(asdf list-all python | grep -E "^$ver\.[0-9]+$" | tail -n 1)
    printf "%-12s" "$version"
  done
  echo
}

function list_golang_versions() {
  local versions=("1.21" "1.20" "1.19")
  local absolute_latest=$(asdf list-all golang | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$" | tail -n 1)

  printf "${BOLD}${GREEN}%-10s %-8s:${NORMAL}${YELLOW} " "Golang" "$absolute_latest"

  for ver in "${versions[@]}"; do
    local version=$(asdf list-all golang | grep -E "^$ver\.[0-9]+$" | tail -n 1)
    printf "%-12s" "$version"
  done
  echo
}

function list_yarn_versions() {
  local absolute_latest=$(asdf list-all yarn | tail -n 1)
  printf "${BOLD}${GREEN}%-10s %-8s:${NORMAL}${YELLOW} %-12s\n" "Yarn" "$absolute_latest" "$absolute_latest"
}

function list_1password_versions() {
  local absolute_latest=$(asdf list-all 1password-cli | tail -n 1)
  printf "${BOLD}${GREEN}%-10s %-8s:${NORMAL}${YELLOW} %-12s\n" "1Password" "$absolute_latest" "$absolute_latest"
}

function list_all_versions() {
  printf "\n%16s\n" "${BOLD}${GREEN}Latest${NORMAL}"

  list_node_versions
  list_python_versions
  list_golang_versions
  list_yarn_versions
  list_1password_versions
  list_php_versions
  list_ruby_versions

  echo "\n"
}



function list_php_versions() {
  local versions=("8.1" "8.0" "7.4")
  local absolute_latest=$(asdf list-all php | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$" | tail -n 1)

  printf "${BOLD}${GREEN}%-10s %-8s:${NORMAL}${YELLOW} " "PHP" "$absolute_latest"

  for ver in "${versions[@]}"; do
    local version=$(asdf list-all php | grep -E "^$ver\.[0-9]+$" | tail -n 1)
    printf "%-12s" "$version"
  done
  echo
}

function list_ruby_versions() {
  local versions=("3.2" "3.1" "3.0" "2.7")
  local absolute_latest=$(asdf list-all ruby | grep -E "^[0-9]+\.[0-9]+\.[0-9]+$" | tail -n 1)

  printf "${BOLD}${GREEN}%-10s %-8s:${NORMAL}${YELLOW} " "Ruby" "$absolute_latest"

  for ver in "${versions[@]}"; do
    local version=$(asdf list-all ruby | grep -E "^$ver\.[0-9]+$" | tail -n 1)
    printf "%-12s" "$version"
  done
  echo
}
