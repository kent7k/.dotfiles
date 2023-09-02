#!/bin/bash
# Associative arrays are only available in Bash 4 or later.
# But macOS only supports Bash 3.
# Therefore, an array is declared using declare -a instead.
declare -a LINKS=(
  ".tmux/.tmux.conf" "$HOME/.tmux.conf"
  ".zsh/.zshrc" "$HOME/.zshrc"nvim
#  ".zsh/0_terminal/.alacritty.yml" "$HOME/.config/.alacritty.yml"

  # neovim
  ".zsh/0_terminal/.nvim/init.vim" "$HOME/.config/nvim/init.vim"
  ".zsh/0_terminal/.nvim/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"

#  ".zsh/1_infrastructure/git/.gitconfig" "$HOME/.gitconfig"
#  ".zsh/2_languages/asdf/.tool-versions" "$HOME/.tool-versions"
#  ".zsh/3_packages/.crates.toml" "$HOME/.cargo/.crates.toml"

  # Note: `navi info config-path` is the command to find navi's default configuration file location
#  ".zsh/0_terminal/.navi.yaml" "/Users/kent/Library/Application Support/navi/config.yaml"

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
