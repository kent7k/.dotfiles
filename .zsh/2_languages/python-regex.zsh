alias regob='ergob'
function regob() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: regob <command>"
    return 1
  fi

  python "${DOT_FILES}/.zsh/2_languages/python-regex.zsh"
}
