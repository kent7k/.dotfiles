# Overrides rm -i alias which makes rm prompt for every action.
# ------------------------
# When nocorrect isn't set, zsh will try to correct a misspelled command. But it's not always what you want.
# $ nslooku
# zsh: correct nslooku to nslookup [nyae]?
# ------------------------
# alias rm='nocorrect rm'

if type trash > /dev/null 2>&1; then
    alias rm='trash -r'
fi