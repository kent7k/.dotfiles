# Managed contents by 'conda init'
__conda_setup=$("$HOME/opt/anaconda3/bin/conda" "shell.zsh" "hook" 2>/dev/null)
# shellcheck disable=SC2181
if [ $? -eq 0 ]; then
	eval "$__conda_setup"
else
	if [ -f "$HOME/opt/anaconda3/etc/profile.d/conda.sh" ]; then
		. "$HOME/opt/anaconda3/etc/profile.d/conda.sh"
	else
		export PATH="$HOME/opt/anaconda3/bin:$PATH"
	fi
fi
unset __conda_setup
