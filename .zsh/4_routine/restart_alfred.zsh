function alfred_restart() {
  if [[ -n "$(/usr/bin/pgrep -f 'Alfred 4.app')" ]]; then
    osascript -e 'tell application "Alfred" to quit' \
      -e 'delay 1' \
      -e 'tell application "Alfred" to activate'
  fi
}
