BREW_FILES= \
	${BREW_PATH}/00-app.Brewfile \
	${BREW_PATH}/00-bash.Brewfile \
	${BREW_PATH}/00-terminal.Brewfile \
	${BREW_PATH}/01_infrastructure.Brewfile \
	${BREW_PATH}/09-database.Brewfile \
	${BREW_PATH}/09-img.Brewfile \
	${BREW_PATH}/09-lint.Brewfile \
	${BREW_PATH}/09-others.Brewfile

all: init link defaults brew install_via_homebrew

install_via_homebrew:
	for file in $(BREW_FILES); do \
      echo "-------------------------"; \
      echo "brew bundle --file $$file"; \
      brew bundle --file "$$file"; \
    done
    echo "------ finish install_via_homebrew ------"

# Link dotfiles.
link:
	chmod +x .sh/symbolic-link.sh
	.sh/symbolic-link.sh
