alias prime='prime'
function prime_video() {
	osascript -e 'tell application "/Applications/Google Chrome.app" to make new window' \
		-e 'tell application "/Applications/Google Chrome.app" to open location "https://www.amazon.co.jp/-/en/gp/video/storefront"' \
		-e 'tell application "/Applications/Google Chrome.app" to activate' \
		-e 'tell application "System Events" to keystroke "o" using {option down, control down}'
}
