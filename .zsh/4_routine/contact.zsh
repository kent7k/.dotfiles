alias sns='check_sns'
function check_sns() {
  osascript <<EOF
    tell application "/Applications/LINE.app" to activate
    delay 5

    tell application "/Applications/Google Chrome.app"
      make new window
      open location "https://www.messenger.com/t"

      tell application "System Events"
        keystroke "g" using {option down, control down}
      end tell

      make new window
      open location "https://www.instagram.com/"

      tell application "System Events"
        key code 47 using {option down, control down}
      end tell
    end tell

    tell application "/Applications/Tweetbot.localized/Tweetbot.app"
      delay 3
      activate

      tell application "System Events"
        keystroke "g" using {option down, control down}
        keystroke "q" using {option down, control down}
      end tell
    end tell
EOF
}

# Define the function to quit social networking apps and close certain tabs in Google Chrome
alias qsns='quit_sns'
function quit_sns() {
  osascript -e 'quit app "/Applications/Tweetbot.localized/Tweetbot.app"'
  osascript -e 'quit app "/Applications/LINE.app"'

  # Use a heredoc to send multiple lines of AppleScript to close Chrome tabs
  osascript <<EOF
    tell application "/Applications/Google Chrome.app"
      close tab 1 of window 1
      	-- "window 1" refers to the frontmost window, and "tab 1" refers to the leftmost tab in that window
      close tab 1 of window 2
      -- "window 2" refers to the next frontmost window, and "tab 1" means same.
    end tell
EOF
}
