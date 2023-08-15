# COLORS (https://colors.sh)
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
GREEN="\033[38;5;40m"
RESET="\033[0m"

if [ "${PWD##*/}" != "dotconfig" ]; then
  echo "Run the setup script from the project directory."
  exit
fi

function copyBashAliases {
  if [ -f ./.bash_aliases ]; then
    echo -e "${YELLOW}.bash_aliases${RESET}"
    if [ ! -f ~/.bash_aliases ]; then
      echo -e "  Copying .bash_aliases > ~/.bash_aliases"
      cat ./.bash_aliases > ~/.bash_aliases
    else
      read -p "  ~/.bash_aliases already exists, [o]verwrite/[a]ppend/[S]kip? " action
      if [[ $action == [oO] ]]; then
        cat ./.bash_aliases > ~/.bash_aliases
      elif [[ $action == [aA] ]]; then
        cat ./.bash_aliases >> ~/.bash_aliases
      else
        echo "  Skipping..."
      fi
    fi
    echo -e "  ${GREEN}done${RESET}"
  fi
}

function copyConfigs {
  if [ -f ./kitty/*.conf ]; then
   if [ ! -d ~/.config/kitty ]; then
      echo "Creating ~/.config/kitty folder..."
      mkdir -p ~/.config/kitty
    fi

    for f in kitty/*.conf
    do
      echo -e "${YELLOW}${f}${RESET}"
      if [ ! -f ~/.config/$f ]; then
        echo -e "  Copying $f > ~/.config/$f"
        cat $f > ~/.config/$f
      else
        read -p "  ~/.config/$f already exists, [o]verwrite/[a]ppend/[S]kip? " action
        if [[ $action == [oO] ]]; then
          cat $f > ~/.config/$f
        elif [[ $action == [aA] ]]; then
          cat $f >> ~/.config/$f
        else
          echo "  Skipping..."
        fi
      fi
      echo -e "  ${GREEN}done${RESET}"
    done
  fi
}

if [[ $1 && $1 == "--all" ]]; then
  copyBashAliases
  copyConfigs
else
  read -p "Copy .bash_aliases?(y/N) " c1
  if [[ $c1 == [yY] ]]; then
    copyBashAliases
  fi

  read -p "Copy configuration files?(y/N) " c2
  if [[ $c2 == [yY] ]]; then
    copyConfigs
  fi
fi

if [[ $c1 || $c2 ]]; then
  echo -e "\n${BOLD}${GREEN}All set!${RESET}"
fi
