# COLORS (https://colors.sh)
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
GREEN="\033[38;5;40m"
RESET="\033[0m"

if [ "${PWD##*/}" != "dotconfig" ]; then
  echo "Run the setup script from the project directory."
  exit
fi

if [ -f ./.bash_aliases ]; then
  echo -e "${YELLOW}.bash_aliases${RESET}"
  if [ ! -f ~/.bash_aliases ]; then
    echo -e "  Copying .bash_aliases > ~/.bash_aliases"
    cat ./.bash_aliases > ~/.bash_aliases
  else
    read -p "  ~/.bash_aliases file already exists, [o]verwrite/[a]ppend/[S]kip? " action
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
    fi
    echo -e "    ${GREEN}done${RESET}"
  done
  echo -e "  ${GREEN}done${RESET}"
fi

echo -e "${BOLD}${GREEN}Script finished. Enjoy!${RESET}"
