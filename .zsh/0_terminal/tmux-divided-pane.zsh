# You can set tmux-panes as you use habitually like below.
# Author's setting is not public by .gitignore because sensitive information of project is included.
# --------------------------------------------------------
# function ideAsUsual() {
#   dividePaneIntoQuarters "${HOME}/ghq/working-directory/"
#   tmux send-keys -t 1 "open https://some-websites-you-need" C-m; sleep 0.5
#   tmux send-keys -t 2 "yarn start" C-m
#   tmux send-keys -t 3 "docker compose up" C-m
#   finishSettingPanes
#  ;;
# --------------------------------------------------------
    
function dividePaneIntoQuarters () {
  cd "$1" || exit

  # Set both 1st & 2nd quadrant (= 象限 in Japanese)
    tmux split-window -v -p 50
    tmux select-pane -t 1
    tmux split-window -h -p 50

  # Set both 3rd & 4th quadrant
    tmux select-pane -t 3; sleep 0.5
    tmux split-window -h -p 50
    tmux send-keys -t 3 "cd $2" C-m
    tmux send-keys -t 4 "cd $2" C-m

  # Clear & select-pane -t 1
    for i in {1..4}; do tmux send-keys -t "$i" "clear" C-m; done
    tmux select-pane -t 1
}

function dividePaneIntoThirdsTypeReversedT () {
    cd "$1" || exit
    tmux split-window -v
    tmux select-pane -t 1
    tmux resize-pane -D 10
    tmux split-window -h
    for i in {1..3}; do tmux send-keys -t "$i" "clear" C-m; done
    tmux select-pane -t 1
}

function dividePaneIntoThirdsTypeNormalT () {
    cd "$1" || exit
    tmux split-window -v
    tmux select-pane -t 1
    tmux resize-pane -D 10
    tmux split-window -h
    for i in {1..3}; do tmux send-keys -t "$i" "clear" C-m; done
    tmux select-pane -t 1
}

function dividePaneIntoThirdsTypeJapaneseUp () {
    # JapaneseUp means Character '上' in Japanese
    cd "$1" || exit
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
  tmux select-pane -t 1;
  clear
}

function killAllPanes() {
  for i in {1..10}; do
    tmux send-keys -t "$i" C-c;
  done

  sleep 4 # sleep 1 wouldn't work "tmux kill-pane".

  # TODO: Set the upper limit by getting the last number of a tmux-pane; 10 is just a big number.
  for i in {2..10}; do
    tmux send-keys -t "$i" "tmux kill-pane" C-m;
  done

  sleep 5

  tmux send-keys -t 1 "tmux kill-pane" C-m;
}
