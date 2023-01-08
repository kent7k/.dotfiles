# Makes version by asdf interactively.
# TODO: When using this, one couldn't escape from a loop.
alias asdfa='asdfa'
function asdfa () {
  asdf current
  echo "----------------------------"
  echo "Do you wanna list up all plugins? (It takes a minute) (y/[n])"
  read input

  case $input in
    [Yy]* )
      echo "----------------------------"
      echo "Note: if the plugins is new, then 'asdf plugin add python'"
      echo "Note: if the plugins is old, then 'asdf plugin remove python'"
      echo "----------------------------"
      echo "Let's show all plugins"
      asdf plugin list all
      echo "----------------------------"
      ;;
    "" | * )
      echo "----------------------------"
      echo "Enter Plugin to search version. (Above/Sth)"
      read pluginName
      asdf list all "$pluginName" && \
      echo "----------------------------"
      latestVersion=$(asdf latest $pluginName)
      echo "$pluginName's latest stable version is $latestVersion"
      echo "----------------------------"
      installedVersion=$(asdf list $pluginName)
      echo "Installed $pluginName's versions are ..."
      echo $installedVersion
      echo "----------------------------"
      asdf_SelectPluginVersion
      ;;
  esac
}

alias asdf_SelectPluginVersion='asdf_SelectPluginVersion'
function asdf_SelectPluginVersion () {
    echo "Please, Choose Version you wanna install from Above ( $latestVersion /[n])"
    read pluginVersion

    case $pluginVersion in
      "" )
              asdf_ShownVersion
        ;;
      * )
              echo "Let's install $pluginName $pluginVersion"
              sleep 0.5
              asdf install $pluginName $pluginVersion
        ;;
    esac

  echo "----------------------------"
  asdf_ShownVersion
}

alias asdf_ShownVersion='asdf_ShownVersion'
function asdf_ShownVersion () {
    echo "Installed $pluginName"
    asdf list $pluginName && \
    echo "----------------------------"
    asdf_SetVersion
}

alias asdf_SetVersion='asdf_SetVersion'
function asdf_SetVersion () {
    echo "Are you wanna set $pluginName $pluginVersion ? ([g]/l/n)"
    asdf list $pluginName && \

    read setting

    case $setting in
      "" | [g] )
          asdf global $pluginName $pluginVersion
          echo "DONE: Setting $pluginName $pluginVersion as global"
          echo "----------------------------"
        ;;
      [l] )
          asdf local $pluginName $pluginVersion
          echo "DONE: Setting $pluginName $pluginVersion as local"
          echo "----------------------------"
        ;;
      * )
          echo "----------------------------"
        ;;
    esac

    asdf_uninstall
}

alias asdf_uninstall='asdf_uninstall'
function asdf_uninstall () {
    echo "Wanna Uninstall Above?　( $pluginVersion / [n] )"
    read deletedPluginVersion

    case $deletedPluginVersion in
      "" )
            echo "----------------------------"
            echo "Done"
        ;;
      * )
            echo "----------------------------"
            asdf uninstall $pluginName $deletedPluginVersion && \
            echo "You Finished uninstalling $pluginName $deletedPluginVersion"
            echo "----------------------------"
            asdf_ShownVersion
        ;;
    esac
}
