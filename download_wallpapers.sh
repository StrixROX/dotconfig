# COLORS (https://colors.sh)
BOLD="\033[1m"
YELLOW="\033[38;5;11m"
GREEN="\033[38;5;40m"
RESET="\033[0m"

function downloadWallpapers {
  echo -e "\n${YELLOW}Wallpaper download${RESET}"

  outputDir="./Wallpapers"
  read -p "  Specify target directory for downloaded wallpapers:(${outputDir}) " input

  if [[ $input && $input != "" ]]; then
    outputDir=$input
  fi

  outputDir="${outputDir/'~'/$HOME}"

  if [ ! -d $outputDir ]; then
    read -p "  Target directory not found. Create directory?(Y/n) " choice
    if [[ $choice == [yY] || $choice == "" ]]; then
      mkdir -p $outputDir
    else
      echo "  No target directory. Aborting..."
    fi
  fi

  if [ -f ./wallpaper-list ]; then
    cat ./wallpaper-list | while read line; do (downloadAndSaveAs $line); done
  fi

  echo -e "  ${GREEN}done${RESET}"
}

function downloadAndSaveAs {
  if [ -d $outputDir ];then
    curl $1 > $outputDir/$2
  fi
}
