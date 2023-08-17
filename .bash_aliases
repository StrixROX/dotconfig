alias c="clear"
alias l="ls --group-directories-first"
alias la="ls -a --group-directories-first"
alias editals="nano ~/.bash_aliases"
alias loadbash="source ~/.bashrc"

# Bash prompt customization
#CYAN="\033[038;5;51m"
#GREEN="\033[038;5;40m"
#RESET="\033[0m"

# only this works in Arch
CYAN="\[$(tput setaf 51)\]"
GREEN="\[$(tput setaf 40)\]"
RESET="\[$(tput sgr0)\]"

# checks whether the current dir is a part of a git repo
# if yes, returns the current active branch
getGitBranch() {
  local branch=$(git branch 2> /dev/null | sed -n '/^[^*]/d;s/*\s*\(.*\)/\1/p')

  if [[ -n "$branch" ]]; then
    if [[ -n "$(git status --porcelain)" ]]; then
      echo "⦓  $branch* ⦔"
    else
      echo "⦓  $branch  ⦔"
    fi
  fi
}

PS0=''
PS1="${CYAN}\n\w${GREEN} \$(getGitBranch)\n${CYAN}⦔ ${RESET}"
PS2='... '
