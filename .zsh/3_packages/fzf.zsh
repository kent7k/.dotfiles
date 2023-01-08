# Adjusts the window size of fzf.
export FZF_DEFAULT_OPTS='--height 80% --reverse --border'

# Applies bat to ripgrep
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# Applies bat to fzf
export FZF_CTRL_T_OPTS='--preview "bat  --color=always --style=header,grid --line-range :100 {}"'

# Browses files with fzf and bat
# shellcheck disable=SC2142
# TODO: LINT
alias ff='(){ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/$1.*"}'
