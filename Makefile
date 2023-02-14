BREWFILES= \
	${BREWPATH}/00-app.Brewfile \
	${BREWPATH}/00-bash.Brewfile \
	${BREWPATH}/00-terminal.Brewfile \
	${BREWPATH}/01_infrastructure.Brewfile \
	${BREWPATH}/09-database.Brewfile \
	${BREWPATH}/09-img.Brewfile \
	${BREWPATH}/09-lint.Brewfile \
	${BREWPATH}/09-others.Brewfile

all: init link defaults brew install_via_homebrew

install_via_homebrew:
	for file in $(BREWFILES); do \
      echo "-------------------------"; \
      echo "brew bundle --file $$file"; \
      brew bundle --file "$$file"; \
    done

# Link dotfiles.
link:
	chmod +x .sh/symbolic-link.sh
	.sh/symbolic-link.sh
