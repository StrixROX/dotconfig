# COLORS (https://colors.sh)
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
GREEN="\033[38;5;40m"
RESET="\033[0m"

if [ "${PWD##*/}" != "dotconfig" ]; then
  echo "Run the setup script from the project directory."
  exit
fi

if [ -f .bash_aliases ]; then
  echo -e "${YELLOW}Copying .bash_aliases > ~/.bash_aliases${RESET}"
  if [ ! -f ~/.bash_aliases ]; then
    cat .bash_aliases > ~/.bash_aliases
    echo -e "  ${GREEN}done${RESET}"
  else
    read -p "  ~/.bash_aliases file already exists, [o]verwrite/[a]ppend/[S]kip? " action
    if [[ $action == [oO] ]]; then
      cat .bash_aliases > ~/.bash_aliases
    elif [[ $action == [aA] ]]; then
      cat .bash_aliases >> ~/.bash_aliases
    else
      echo "  Skipping..."
    fi
  fi
fi

echo -e "${BOLD}${GREEN}Script finished. Enjoy!${RESET}"
