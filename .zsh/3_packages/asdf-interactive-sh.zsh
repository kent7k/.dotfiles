# Source File: /Users/kent/.dotfiles/.zsh/3_packages/asdf-interactive-sh.zsh

# Define color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

function asdf_SelectPluginVersion() {
    local pluginName="$1"
    local suggestedVersion="$2"
    local pluginVersion=""
    local availableVersions
    local majorMinorVersions
    local selectedMajorMinor
    local patchVersions

    availableVersions=$(asdf list all "$pluginName")

    # Get unique major.minor versions
    majorMinorVersions=$(echo "$availableVersions" | awk -F. '{print $1"."$2}' | uniq)

    # Prompt user to select major.minor version
    selectedMajorMinor=$(echo "$majorMinorVersions" | fzf --prompt "${BOLD}Select the major.minor version:${NC} ")

    # Exit if no version was selected
    if [ -z "$selectedMajorMinor" ]; then
        echo "${YELLOW}No version selected. Exiting.${NC}"
        return
    fi

    # Now show the patch versions for the selected major.minor
    patchVersions=$(echo "$availableVersions" | grep "^$selectedMajorMinor")

    pluginVersion=$(echo "$patchVersions" | fzf --prompt "${BOLD}Select the patch version for $selectedMajorMinor:${NC} ")

    # Continue only if a version is selected
    if [ -n "$pluginVersion" ]; then
        echo "${GREEN}Installing $pluginName $pluginVersion...${NC}"
        asdf install "$pluginName" "$pluginVersion"
        print_separator
        asdf_SetVersion "$pluginName" "$pluginVersion"
    else
        echo "${YELLOW}Skipped installation.${NC}"
    fi
}

function print_separator() {
    echo "${BOLD}${GREEN}----------------------------${NC}"
}

function asdfa() {
    # Display currently installed versions
    asdf current
    print_separator

    echo "${BOLD}Do you want to list all plugins?${NORMAL} This might take a minute. (y/[n])"
    read -r input

    case $input in
    [Yy]*)
        print_separator
        echo "${BOLD}Displaying all plugins:${NC}"
        asdf plugin list all
        print_separator
        ;;
    esac

    # Use fzf to let the user select the plugin
    local pluginName=$(asdf plugin list | fzf --prompt "${BOLD}Select the plugin to manage its version:${NC} ")

    # If no plugin was selected, exit
    if [ -z "$pluginName" ]; then
        echo "${YELLOW}No plugin selected. Exiting.${NC}"
        return
    fi

    print_separator
    local latestVersion
    local installedVersion

    latestVersion=$(asdf latest $pluginName)
    echo "${BOLD}${pluginName}'s latest stable version is ${latestVersion}${NC}"
    print_separator

    installedVersion=$(asdf list $pluginName)
    echo "${BOLD}Installed ${pluginName}'s versions are:${NC}"
    echo "$installedVersion"
    print_separator

    asdf_SelectPluginVersion "$pluginName" "$latestVersion"
    asdf_uninstall "$pluginName"
}

function asdf_SetVersion() {
    local pluginName="$1"
    local pluginVersion="$2"

    echo "${BOLD}How do you want to set the version for $pluginName?${NC}"
    echo "(g)lobal, (l)ocal, or (n)ot now"
    read -r setting

    case $setting in
    g|G)
        asdf global "$pluginName" "$pluginVersion"
        echo "${GREEN}DONE: Set $pluginName $pluginVersion as global${NC}"
        ;;
    l|L)
        asdf local "$pluginName" "$pluginVersion"
        echo "${GREEN}DONE: Set $pluginName $pluginVersion as local${NC}"
        ;;
    *)
        print_separator
        ;;
    esac
}

function asdf_uninstall() {
    local pluginName="$1"

    # While loop to keep the uninstall prompt going
    while true; do
        # Fetch and count the current installed versions
        local installedVersions
        installedVersions=$(asdf list "$pluginName")
        local installedVersionsCount
        installedVersionsCount=$(echo "$installedVersions" | wc -l | awk '{print $1}')

        # Print installed versions
        print_separator
        echo "${BOLD}Installed versions of $pluginName:${NC}"
        echo "$installedVersions"
        print_separator

        # If there's only one version installed, break the loop
        if (( installedVersionsCount <= 1 )); then
            echo "${YELLOW}Only one version remains for $pluginName. Exiting uninstallation loop.${NC}"
            break
        fi

        # Use the updated list of versions for fzf selection
        deletedPluginVersion=$(echo "$installedVersions" | fzf --prompt "${BOLD}Select a version of $pluginName to uninstall or ESC to skip:${NC} " | awk '{$1=$1};1')

        # If user skips (by pressing ESC in fzf), break the loop
        if [ -z "$deletedPluginVersion" ]; then
            break
        fi

        # Uninstall the selected version
        asdf uninstall "$pluginName" "$deletedPluginVersion"

        if [[ $? -eq 0 ]]; then
            echo "${GREEN}Uninstalled $pluginName $deletedPluginVersion${NC}"
            print_separator
        else
            echo "${RED}There was an error uninstalling $pluginName $deletedPluginVersion${NC}"
            print_separator
        fi
    done
}
