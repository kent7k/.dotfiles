# exa is an improved file lister with more features and better defaults.

# Makes exa command more accessible.
if [[ $(command -v exa) ]]; then
	alias e='exa --icons --git'
	alias l=e
	alias ls=e
	alias ea='exa -a --icons --git'
	alias la=ea
	alias ee='exa -aahl --icons --git'
	alias ll=ee
	alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
	alias lt=et
	alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
	alias lta=eta
	alias l='clear && ls'
fi
