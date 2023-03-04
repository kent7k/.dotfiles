# Set asdf's config.
. "$HOME"/.asdf/asdf.sh
export ASDF_CONFIG_FILE="$ASDF_CONFIG_PATH"

# append completions to fpath
fpath=("${ASDF_DIR}/completions" "$fpath")
