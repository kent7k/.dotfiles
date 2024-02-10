# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.pre.bash"
. "$HOME/.cargo/env"

if [ "$(uname)" == "Linux" ]; then
    export DOT_FILES=$(echo /mnt/c/Users/k*/.dotfiles | cut -d' ' -f1)
elif [ "$(uname)" == "Darwin" ]; then
    export DOT_FILES=$(echo /Users/k*/.dotfiles | cut -d' ' -f1)
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# NOTE (Makefile.0-setup方式)
#
# %$.PHONY: setup-brew
#
# setup-brew:
#        @(echo; echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /mnt/c/Users/USER_NAME/.zshrc
#        @(echo; echo 'eval "$$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /mnt/c/Users/USER_NAME/.bashrc

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.post.bash"
