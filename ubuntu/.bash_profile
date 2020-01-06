export GOPATH="$HOME/gopath"
export PATH="$HOME/.go/bin:$HOME/gopath/bin:$HOME/gopath:$HOME/.npm-global/bin:$HOME/AppImage:$HOME/.rvm/bin:$HOME/.cargo/bin:$PATH"
export EDITOR="subl -w"
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"
export RIPGREP_CONFIG_PATH="$HOME/Development/dotfiles/.rgrc"
export DISABLE_AUTO_TITLE=true

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -o'
alias os_upgrade="~/Development/dotfiles/bin/os_upgrade"
alias t='tree -a --prune -I $(cat .gitignore | egrep -v "^#.*$|^[[:space:]]*$" | tr "\\n" "|")'
alias ripgrep="rg"

function set_prompt() {
  PS1_USERNAME="\u"
  PS1_PWD="\w"
  PS1_IS_ROOT="\$"
  BG_BLACK="\[$(tput setab 0)\]"
  BG_GREY="\[$(tput setab 8)\]"
  BG_RED="\[$(tput setab 1)\]"
  BG_WHITE="\[$(tput setab 7)\]"

  RED="\[$(tput setaf 1)\]"
  GREEN="\[$(tput setaf 2)\]"
  GREY="\[$(tput setaf 8)\]"
  BLACK="\[$(tput setaf 0)\]"
  WHITE="\[$(tput setaf 7)\]"
  RESET_COLOR="\[$(tput sgr0)\]"

  if [[ -z "${TMUX}" ]]; then
    export PS1="$BG_RED$BLACK $PS1_USERNAME $RED$BG_WHITE$BG_WHITE$BLACK $PS1_PWD $WHITE$BG_GREY$GREEN\$(__git_ps1)$BLACK $GREY$BG_BLACK$RESET_COLOR "
  else
    export PS1="$BG_RED$BLACK $PS1_USERNAME:$PS1_PWD $BG_BLACK$RED$RESET_COLOR "
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
  if [[ $# -gt 0 ]]; then
    builtin cd "$1" && ls -a
  else
    builtin cd "$@" && ls -a
  fi
}

function g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"
