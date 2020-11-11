# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

if [[ -e ~/.ssh/known_hosts ]]; then
  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp mosh
fi

# Don't put things above this line.

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

export GOPATH="$HOME/gopath"
export PATH="$PATH:$HOME/.go/bin:$HOME/gopath/bin:$HOME/gopath:$HOME/.npm-global/bin:$HOME/AppImage:$HOME/.rvm/bin:$HOME/.cargo/bin:$HOME/Development/dotfiles/bin:$HOME/.rvm/bin"
export EDITOR="subl -w"
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export XAUTHORITY="$XDG_CACHE_HOME/Xauthority"
export RIPGREP_CONFIG_PATH="$HOME/Development/dotfiles/.rgrc"
export DISABLE_AUTO_TITLE=true

export FZF_DEFAULT_COMMAND="fd . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=erasedups:ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=100000
export HISTFILESIZE=500000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

set_prompt() {
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

git_add_fzf() {
  local files

  files=$(
    git -c color.status=always status --short |
    fzf-tmux -m --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' --ansi | cut -c2- | sed "s/.* //"
  )

  for f in $files; do
    git add $f
    echo "Staged $f"
  done
}

# Create a new directory and enter it
md() {
  mkdir -p "$@" && cd "$@" || return
}

my_path() {
  IFS=":";
  for p in $PATH;
    do echo $p;
  done
}

cdls() {
  if [[ $# -gt 0 ]]; then
    builtin cd "$1"; ls -a
  else
    builtin cd "$@"; ls -a
  fi
}

g() {
  if [[ $# -gt 0 ]]; then
    git "$@"
  else
    git status
  fi
}

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/dddev/Downloads/google-cloud-sdk-209.0.0-linux-x86_64/google-cloud-sdk/path.bash.inc' ]; then source '/home/dddev/Downloads/google-cloud-sdk-209.0.0-linux-x86_64/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/dddev/Downloads/google-cloud-sdk-209.0.0-linux-x86_64/google-cloud-sdk/completion.bash.inc' ]; then source '/home/dddev/Downloads/google-cloud-sdk-209.0.0-linux-x86_64/google-cloud-sdk/completion.bash.inc'; fi

source ~/.local_bashrc
source $HOME/.cargo/env
