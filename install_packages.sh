function installPackages {
  source /etc/os-release

  if [[ $NAME == *"Fedora"* ]]; then
    if [ -f ./package-lists/package-list.fedora ]; then
      sudo dnf install $(cat ./package-lists/package-list.fedora)
    else
      echo "No package-list file for: Fedora"
    fi
  fi

  echo -e "  ${GREEN}done${RESET}"
}
