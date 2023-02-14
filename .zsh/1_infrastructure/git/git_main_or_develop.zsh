function access_main_or_develop_by() {
  printf "\n%s\n" "$(c_green "? Branch") ([main]/d:develop)"
  read -r -s user_input
  target="main"
  case $user_input in
    "m") target="main" ;;
    "d") target="develop" ;;
  esac
  "$1" "$target"
}
