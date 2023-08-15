# COLORS (https://colors.sh)
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
GREEN="\033[38;5;40m"
RESET="\033[0m"

function installPackages {
  echo -e "${YELLOW}Package installation${RESET}"

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
