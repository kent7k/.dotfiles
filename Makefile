BASE_PATH = $(HOME)/.dotfiles/.makefile
DOT_FILES = $(HOME)/.dotfiles/

include $(BASE_PATH)/Makefile.0-init
include $(BASE_PATH)/Makefile.1-brew
include $(BASE_PATH)/Makefile.2-zsh
include $(BASE_PATH)/Makefile.3-asdf
include $(BASE_PATH)/Makefile.4-neovim
include $(BASE_PATH)/Makefile.8-appstore-setup
include $(BASE_PATH)/Makefile.9-formulae-setup
