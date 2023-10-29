# Switches AWS Profile
# NOTE: aws cli refers $AWS_PROFILE, reflecting to profile.
alias awsp='aws_profile'
function aws_profile() {
	local profile
	# sed hides default profile
	profile=$(aws configure list-profiles | sed '/default/d' | fzf)
	export AWS_PROFILE="$profile"
}
