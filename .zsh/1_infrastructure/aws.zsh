# Switches AWS Profile
# NOTE: aws cli refers $AWS_PROFILE, reflecting to profile.
alias awsp='aws_profile'
function aws_profile() {
  # sed hides default profile
  local profile=$(aws configure list-profiles | sed "/default/d" | sort | fzf )
  export AWS_PROFILE="$profile";
}
