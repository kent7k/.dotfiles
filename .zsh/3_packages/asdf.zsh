# Set asdf's config.
. "$HOME"/.asdf/asdf.sh
export ASDF_CONFIG_FILE="${DOT_FILES}/2_languages/asdf/.asdfrc"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
