# Set asdf's config.
. "$HOME"/.asdf/asdf.sh
<<<<<<< HEAD
export ASDF_CONFIG_FILE="$ASDF_CONFIG_PATH"
=======
export ASDF_CONFIG_FILE="${DOT_FILES}/.zsh/2_languages/.asdfrc"
>>>>>>> 1a0fb2a (Arrange Directories 230304)

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
