# Sets GitHub CLI setting for completion
eval "$(gh completion -s zsh)"

# Makes git auto completion faster favouring for local completions
__git_files () {
    _wanted files expl 'local files' _files
}

# Opens the project repository in browser
alias ghb='gh browse'

# Makes git logs more readable
alias gitlog="ghq list | fzf --preview "git --git-dir $(ghq root)/{}/.git log --date=short --pretty=format:'-%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --color""

# Makes git more easy to command
# TODO: Makes workflows or Moves to navi, or Uses Fig.
alias gist='git status'
alias gilo='git log --oneline --graph'
alias girl='git reflog'
alias giba='git branch -a'
alias gia='(){git add $1}'
alias gic='(){git commit -m $1}'
alias gica='(){git commit -am $1}'
alias gip='git push'

# Pushes to the develop branch.
gmpd () {
    git pull origin develop
    echo "Type branche name to merge : " && read branch;
    git merge ${branch};
    git status;
    echo "Is it okay to continue?" && read;
    git push origin develop
}

# Pushes all changes to current branch.
gcom () {
    git add . && git status
    echo "Type commit comment" && read comment;
    git commit -m ${comment} && git push origin HEAD
}

# Creates a new repository.
alias ghcr='ghcr'
function ghcr () {
    echo "What's the repository's name?" \
    && read argv;
    echo "Please, write the description" \
    && read Description;
    gh repo create "$argv" --private -d "$Description"
    mkdir "$argv"
    cd "$argv"
    echo "# $argv[1]" >> README.md
    git init
    git add README.md
    git commit -m "Initial commit"
    git branch -M main
    git remote add origin git@github.com:kent7k/$argv[1].git
    git remote add origin
    git push -u origin main
}
