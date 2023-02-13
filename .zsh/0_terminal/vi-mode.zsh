# Sets for using vim as nvim.

set -o vi
export EDITOR=vim
export VISUAL=vim

alias vi="nvim"

mvim --version >/dev/null 2>&1
MACVIM_INSTALLED=$?
if [ $MACVIM_INSTALLED -eq 0 ]; then
  alias vim="mvim -v"
fi

# Sets mimic vim functions.
alias :q='exit'
