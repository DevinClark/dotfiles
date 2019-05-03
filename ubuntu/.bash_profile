export GOPATH="$HOME/gopath"
export PATH="$HOME/.go/bin:$HOME/gopath/bin:$HOME/gopath:$HOME/.npm-global/bin:$HOME/AppImage:$PATH"
export EDITOR="subl -w"
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -o'
alias os_upgrade="sudo apt update && sudo apt upgrade -y && sudo snap refresh && sudo gem update"
alias t='tree -a --prune -I $(cat .gitignore | egrep -v "^#.*$|^[[:space:]]*$" | tr "\\n" "|")'
alias ripgrep="rg"

_user_and_host="\[\033[01;32m\]\u@\h"
_cur_location="\[\033[01;34m\]\w"
_colon_separater="\[$(tput setaf 7)\]:"
_prompt_tail="\[$(tput setaf 7)\]$"
_last_color="\[$(tput setaf 7)\]"
#_dot_status="\[$(tput setaf 1)\]•\[$(tput setaf 1)\]"

PS1="$_user_and_host$_colon_separater$_cur_location\[$(tput setaf 1)\]\[$(tput setaf 9)\] $_prompt_tail$_last_color "

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}
