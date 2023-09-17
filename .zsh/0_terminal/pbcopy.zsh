if [[ "$(uname)" == "Linux" ]]; then
  alias open='xdg-open'
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi
