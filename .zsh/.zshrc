# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Always load Fig - seems relevant for both macOS and Ubuntu with zsh

# Platform Specific Configurations
case "$(uname)" in
    "Darwin") # macOS specifics
        # Load cargo environment for macOS
        # . "$HOME/.cargo/env"

        # Evaluate the environment settings required for Homebrew.
        # This ensures that Homebrew binaries and other resources are accessible in the current shell session.
        # The "brew shellenv" command outputs environment variable assignments necessary for Homebrew's operation,
        # such as modifying PATH, MANPATH, and INFOPATH.
        # ------------------------------------------------------------------
        # ❯ /opt/homebrew/bin/brew shellenv
        # export HOMEBREW_PREFIX="/opt/homebrew";
        # export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
        # export HOMEBREW_REPOSITORY="/opt/homebrew";
        # export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
        # export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
        # export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
        # ------------------------------------------------------------------
        eval "$(/opt/homebrew/bin/brew shellenv)"

        # Docker for Mac
        source /Users/kent/.docker/init-zsh.sh || true # Added by Docker Desktop
        echo "$(uname)"
        ;;
    "Linux") # Ubuntu specifics
        # Basic bashrc configurations you might still want with zsh
        # HISTCONTROL=ignoreboth
        # HISTSIZE=1000
        # HISTFILESIZE=2000
        echo "$(uname)"

        # Fixme: PATH for Ubuntu, between eval and export

        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

        # Check for Ubuntu for some specific commands
        if grep -qi "ubuntu" /etc/os-release; then
            # Additional Ubuntu specific configurations can be added here
            # export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
        fi

        ;;
esac

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Loads a few important annexes, without Turbo (this is currently required for annexes).
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust \
    # --- Not working with Fig ---
    # zsh-users/zsh-autosuggestions \
    # zdharma-continuum/fast-syntax-highlighting \
    # zdharma/history-search-multi-word # ctrl+r could search command-history

### End of Zinit's installer chunk

# Loads secrets.
if [ -e ~/.secrets ]; then
  source ~/.secrets
fi

# Set basic configs of zsh
setopt interactivecomments
setopt nonomatch

# Loads configs about zsh.
export DOT_FILES="$HOME/ghq/.dotfiles"
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

for config_file ($DOT_FILES/.zsh/**/*.zsh) source $config_file

# Loads Configs about zsh.
alias sh2='source ~/.zshrc'

# Always load Fig at the end - relevant for both macOS and Ubuntu
source /Users/kent/.docker/init-zsh.sh || true # Added by Docker Desktop

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
