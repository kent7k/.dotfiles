alias sche='schedule'
function schedule() {
  osascript <<EOF
    tell application "Spark" to activate
    open {snippet:fa0}

    tell application "Omnifocus" to activate
    tell application "System Events" to key code 41 using {option down, control down}
EOF
}

function work() {
  osascript -e 'tell application "Omnifocus" to activate'
  open "slack://channel?team=${SLACK_DEFAULT_TEAM}&id=${SLACK_DEFAULT_CHANNEL}"
  osascript -e 'tell application "Slack" to activate'
  osascript -e 'tell application "System Events" to keystroke "q" using {option down, control down}'
  open "${NOTION_DEFAULT_PAGE}"
  osascript -e 'tell application "Notion" to activate'
  osascript -e 'tell application "System Events" to keystroke ";" using {option down, control down}'
}

alias qsch='quit_schedule'

quit_schedule() {
  osascript \
    -e 'quit app "Spark"' \
    -e 'quit app "Fantastical"' \
    -e 'quit app "Omnifocus"' \
    -e 'quit app "Notion"'
  exit
}
