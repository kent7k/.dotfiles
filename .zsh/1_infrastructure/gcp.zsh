# Updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# Enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# Changes to the other project.
alias chp='change_project'
function change_project() {
  gcloud config configurations activate \
    $( \
        gcloud config configurations list \
        | awk '{print $1}' \
        | grep -v NAME \
        | fzf \
    ) && echo "" && gcloud config list
}

