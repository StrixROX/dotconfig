function downloadWallpapers {
  outputDir="./Wallpapers"
  read -p "  Specify target directory for downloaded wallpapers:(${outputDir}) " input

  if [[ $input && $input != "" ]]; then
    outputDir=$input
  fi

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
