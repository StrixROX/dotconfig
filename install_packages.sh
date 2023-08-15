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
      cat ./package-lists/package-list.fedora
      echo ""
      read -p "Proceed?(Y/n) " proceed
      if [[ $proceed == [yY] || $proceed == "" ]]; then
        sudo dnf install $(cat ./package-lists/package-list.fedora)
      fi
    else
      echo "No package-list file for: Fedora"
    fi
  elif [[ $NAME == *"Arch"* ]]; then
    if [ -f ./package-lists/package-list.arch ]; then
      cat ./package-lists/package-list.arch
      echo
      read -p "Proceed?(Y/n) " proceed
      if [[ $proceed == [yY] || $proceed == "" ]]; then
        if [[ $(cat ./package-lists/package-list.arch | grep yay) ]]; then
          echo -e "${YELLOW}yay${RESET}"
          echo -e "  Installing dependency: ${YELLOW}git${RESET}"
          sudo pacman -S git
          echo -e "    ${GREEN}done${RESET}"

          echo "  Downloading binaries"
          git clone https://aur.archlinux.org/yay-bin.git
          echo -e "    ${GREEN}done${RESET}"

          echo "  Installing binaries"
          cd ./yay-bin
          makepkg -si
          cd ..
          echo -e "    ${GREEN}done${RESET}"

          read -p "  Remove downloaded binaries, ./yay-bin/?(Y/n) " removebin
          if [[ $removebin == [yY] ]]; then
            rm -rf yay-bin
            echo -e "    ${GREEN}done${RESET}"
          fi
          echo -e "  ${GREEN}done${RESET}"

          echo "Installing packages with yay"
          sudo yay -S $(cat ./package-lists/package-list.arch)
        else
          echo "Installing packages with pacman"
          sudo pacman -S $(cat ./package-lists/package-list.arch)
        fi
      fi
    else
      echo "No package-list file for: Arch"
    fi
  fi

  echo -e "  ${GREEN}done${RESET}"
}
