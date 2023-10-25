# You can set tmux-panes as you use habitually like below.
# Author's setting is not public by .gitignore because sensitive information of project is included.
# -------------------------- ex ----------------------------
# function setIdeAsUsual() {
#   dividePaneIntoQuarters "${HOME}/ghq/working-directory/"
#   tmux send-keys -t 1 "open https://some-websites-you-need" C-m; sleep 0.5
#   tmux send-keys -t 2 "yarn start" C-m
#   tmux send-keys -t 3 "docker compose up" C-m
#   finishSettingPanes
#  ;;
# --------------------------------------------------------

function dividePaneIntoQuarters() {
  cd "$1" || { echo "Failed to change directory to $1"; exit; }

  # Set both 1st & 2nd quadrant (= 象限 in Japanese).
  tmux split-window -v -p 50
  tmux select-pane -t 1
  tmux split-window -h -p 50

  # Set both 3rd & 4th quadrant.
  tmux select-pane -t 3
  sleep 0.5
  tmux split-window -h -p 50
  tmux send-keys -t 3 "cd $2" C-m
  tmux send-keys -t 4 "cd $2" C-m

  # Clears & Returns to the first pane.
  for i in {1..4}; do tmux send-keys -t "$i" "clear" C-m; done
  tmux select-pane -t 1
}

function dividePaneIntoThirdsTypeReversedT() {
  cd "$1" || { echo "Failed to change directory to $1"; exit; }
  tmux split-window -v
  tmux select-pane -t 1
  tmux resize-pane -D 10
  tmux split-window -h
  for i in {1..3}; do tmux send-keys -t "$i" "clear" C-m; done
  tmux select-pane -t 1
}

function dividePaneIntoThirdsTypeNormalT() {
  cd "$1" || { echo "Failed to change directory to $1"; exit; }
  tmux split-window -v
  tmux select-pane -t 1
  tmux resize-pane -D 10
  tmux split-window -h
  for i in {1..3}; do tmux send-keys -t "$i" "clear" C-m; done
  tmux select-pane -t 1
}

function dividePaneIntoThirdsTypeJapaneseUp() {
  # JapaneseUp means Character '上 = up' in Japanese.
  cd "$1" || { echo "Failed to change directory to $1"; exit; }
  tmux split-window -v
  tmux select-pane -t 1
  tmux resize-pane -D 10
  tmux split-window -h
  tmux select-pane -t 2
  tmux split-window -v
  for i in {1..3}; do tmux send-keys -t "$i" "clear" C-m; done
  tmux select-pane -t 1
}

function finishSettingPanes() {
  tmux select-pane -t 1
  clear
}

function killAllPanes() {
  pane_count=$(tmux list-panes | wc -l)

  for i in $(seq 1 "$pane_count"); do
    tmux send-keys -t "$i" C-c
  done

  # Command 'sleep 1' wouldn't work "tmux kill-pane" in time.
  # Because Docker completes to down, a framework completes to stop, etc.
  sleep 5

  for i in $(seq 1 "$pane_count"); do
    tmux send-keys -t "$i" "tmux kill-pane" C-m
  done
}

function openBrowser() {
  printf "\n%s\n" "$(c_green "Do you want to open in browser?") (y/N)"
  read -r OPEN_BROWSER
  if [ "$OPEN_BROWSER" = "y" ]; then
    for url in "$@"; do
      echo "Opening $url"
      tmux send-keys -t 1 "open $url" C-m
      sleep 0.1
    done
  else
    echo "Okay, you can open in browser later."
  fi
}

function autoOpenBrowser() {
  printf "\n%s\n" "$(c_green "-- Auto Open Browser --") "
  for url in "$@"; do
    echo "Opening $url"
    tmux send-keys -t 1 "open $url" C-m
    sleep 0.1
  done
}

function autoOpenObsidian() {
  for url in "$@"; do
    echo "Opening $url"
    # FIXME: Vars
    tmux send-keys -t 1 "open obsidian://vault/60840284c9cd48be/$url" C-m
    sleep 0.1
  done
}

function sendKeysToPanes234() {
  tmux send-keys -t 2 "$1" C-m
  tmux send-keys -t 3 "$2" C-m
  tmux send-keys -t 4 "$3" C-m
}
