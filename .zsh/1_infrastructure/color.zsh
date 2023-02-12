function c_cyan() {
  color_code="\033[36m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_blue() {
  color_code="\033[34m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_red() {
  color_code="\033[31m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_green() {
  color_code="\033[32m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_yellow() {
  color_code="\033[33m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_gray() {
  color_code="\033[37m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_pink() {
  color_code="\033[35m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_lime() {
  color_code="\033[92m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_purple() {
  color_code="\033[95m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}

function c_light_gray() {
  color_code="\033[37m"
  reset_code="\033[0m"
  echo "$color_code$1$reset_code"
}
