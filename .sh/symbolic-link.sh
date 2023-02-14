# Associative arrays are only available in Bash 4 or later.
# But macOS only supports Bash 3.
# Therefore, an array is declared using declare -a instead.
declare -a LINKS=(
  ".zsh/.zshrc" "$HOME/.zshrc"
  "0_terminal/.alacritty.yml" "$HOME/.config/.alacritty.yml"
  "0_terminal/tmux/.tmux.conf" "$HOME/.tmux.conf"
  "0_terminal/nvim/init.vim" "$HOME/.config/nvim/init.vim"
  "0_terminal/nvim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
  "1_infrastructure/.gitconfig" "$HOME/.gitconfig"
  "2_languages/asdf/.tool-versions" "$HOME/.tool-versions"
  "3_packages/.crates.toml" "$HOME/.cargo/.crates.toml"

  #  FIXME
  #  "3_packages/tealdeer/.tealdeer.toml" "$HOME/Library/Application Support/tealdeer"
)

for ((i = 0; i < ${#LINKS[@]}; i += 2)); do
  SOURCE="${DOT_FILES}/${LINKS[i]}"
  TARGET="${LINKS[i + 1]}"
  if [ ! -e "$TARGET" ]; then
    touch "$TARGET"
  fi
  ln -snfv "$SOURCE" "$TARGET"
done
