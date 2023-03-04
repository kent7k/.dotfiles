# Associative arrays are only available in Bash 4 or later.
# But macOS only supports Bash 3.
# Therefore, an array is declared using declare -a instead.
declare -a LINKS=(
  ".tmux/.tmux.conf" "$HOME/.tmux.conf"
  ".zsh/.zshrc" "$HOME/.zshrc"
<<<<<<< HEAD
  "0_terminal/.alacritty.yml" "$HOME/.config/.alacritty.yml"
  "0_terminal/tmux/.tmux.conf" "$HOME/.tmux.conf"
  "0_terminal/nvim/init.vim" "$HOME/.config/nvim/init.vim"
  "0_terminal/nvim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
  "1_infrastructure/.gitconfig" "$HOME/.gitconfig"
  "2_languages/.tool-versions" "$HOME/.tool-versions"
  "3_packages/.crates.toml" "$HOME/.cargo/.crates.toml"
=======
  ".zsh/0_terminal/.alacritty.yml" "$HOME/.config/.alacritty.yml"
  ".zsh/0_terminal/.nvim/init.vim" "$HOME/.config/nvim/init.vim"
  ".zsh/0_terminal/.nvim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
  ".zsh/1_infrastructure/git/.gitconfig" "$HOME/.gitconfig"
  ".zsh/2_languages/asdf/.tool-versions" "$HOME/.tool-versions"
  ".zsh/3_packages/.crates.toml" "$HOME/.cargo/.crates.toml"
>>>>>>> 1a0fb2a (Arrange Directories 230304)

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
