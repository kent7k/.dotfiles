# Tap the homebrew/services repository to add `brew services` functionality.
#     Error: `brew services` is unavailable because homebrew/services was manually untapped.
#     Run `brew tap homebrew/services` to reenable `brew services`.
tap "homebrew/services"


# sqlite & its dependencies
brew "sqlite"

# postgresql & its dependencies
brew "postgresql@14", restart_service: true
brew "postgresql"

# mysql & its dependencies
brew "mysql"
brew "mysql-client"

# others
brew "golang-migrate"
