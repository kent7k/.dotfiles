# Sets asdf's config.
. $HOME/.asdf/asdf.sh
export ASDF_CONFIG_FILE="${DOT_FILES}/3_packages/asdf/.asdfrc"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
