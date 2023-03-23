# Call Tmux on shell startup
if command -v tmux >/dev/null 2>&1; then
  # Attach to existing Tmux session or start a new one if no sessions exist
  if [[ ! $TERM =~ screen ]] && [ -z "$TMUX" ]; then
    if tmux has-session &>/dev/null; then
      tmux attach
    else
      tmux new-session -s default -d
      tmux
    fi
  fi
fi
