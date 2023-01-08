# Makes stdout of tree command readable on Terminal.
# ---------------------------------------------------
# echo 'Hello, World!' | teee
# => Hello, World!
# echo '{"message":"Hello!"}' | teee | jq -r .message
# => Hello!
# ---------------------------------------------------
alias tree='tee >(pbcopy)'
