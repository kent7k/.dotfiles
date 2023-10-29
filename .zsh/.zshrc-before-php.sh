#!/bin/bash
# Reference:
# Difficulties in installing PHP 8.2 via asdf on M1 Mac
# https://zenn.dev/meihei/articles/85f9c235c666f6

# Define OS-specific paths
PHP_DARWIN="/opt/homebrew/opt/php"
PHP_LINUX="/home/linuxbrew/.linuxbrew/opt/php"

# Determine the operating system
OS_NAME=$(uname)

# Create symbolic links based on OS
if [ "$OS_NAME" == "Linux" ]; then
	ln -s $ZSH_LINUX ~/.asdf/installs/php/8.2
elif [ "$OS_NAME" == "Darwin" ]; then
	ln -s $ZSH_DARWIN ~/.asdf/installs/php/8.2
else
	echo "Unsupported OS: $OS_NAME"
fi
