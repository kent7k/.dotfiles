# Overrides rm -i alias which makes rm prompt for every action.
# ------------------------
# When nocorrect isn't set, zsh will try to correct a misspelled command. But it's not always what you want.
# $ nslooku
# zsh: correct nslooku to nslookup [nyae]?
# ------------------------
# alias rm='nocorrect rm'

if type trash >/dev/null 2>&1; then
	alias rm='trash -r'
fi

# rm regex: ( [^0-9]* => not including 0-9)
#rm -rf <files>

# rm regex: ( [^a-z]*.pl => pl not including a-z ) )
#rm -rf <files>

# rm regex: ( [0-9].pl => pl including 0-9 )
#rm -rf <files>
