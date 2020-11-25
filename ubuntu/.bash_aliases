#!/usr/bin/env bash

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -o'
alias os_upgrade="~/Development/dotfiles/bin/os_upgrade"
alias t='tree -a --prune -I $([ -f ~/.fzf.bash ] && $(cat .gitignore | egrep -v "^#.*$|^[[:space:]]*$" | tr "\\n" "|"))'
alias ripgrep="rg"
alias fd=fdfind
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mux='tmuxinator'
alias g='git status'
alias c='clear'
alias cd='cdls'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Convert git aliases to short commands. Also runs `git status` after.
# Ex. `gciv` instead of `git civ`
git_aliases() {
  IFS=$'\n'
  for i in $(git config --get-regexp "alias."); do
    IFS=$'\n' read -d "" -ra arr <<< "${i// /$'\n'}"
    local name=${arr[0]/alias./}
    alias "g$name= git $name"
  done
}

git_aliases

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
