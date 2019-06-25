export GOPATH="$HOME/gopath"
export PATH="$HOME/.go/bin:$HOME/gopath/bin:$HOME/gopath:$HOME/.npm-global/bin:$HOME/AppImage:$HOME/.rvm/bin:$PATH"
export EDITOR="subl -w"
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -o'
alias os_upgrade="sudo apt update && sudo apt upgrade -y && sudo snap refresh && sudo gem update"
alias t='tree -a --prune -I $(cat .gitignore | egrep -v "^#.*$|^[[:space:]]*$" | tr "\\n" "|")'
alias ripgrep="rg"

function set_prompt() {
  if [[ -z "${TMUX}" ]]; then
    export PS1="\[$(tput setaf 7)\]\u:\w\[$(tput setaf 2)\]\$(__git_ps1)\[$(tput setaf 7)\] $ \[$(tput sgr0)\]"
  else
    export PS1="\[$(tput setaf 7)\]\u:\w\[$(tput setaf 2)\]\[$(tput setaf 7)\] $ \[$(tput sgr0)\]"
  fi
}

if [ -t 0 ]; then
  set_prompt
fi

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@" || return
}

function my_path() { IFS=":"; for p in $PATH; do echo $p; done }

function cd () {
  if [[ $# > 0 ]]; then
    builtin cd "$1" && ls -a
  else
    builtin cd "$@" && ls -a
  fi
}

export PATH="$HOME/.cargo/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*