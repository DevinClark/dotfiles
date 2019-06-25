#!/usr/bin/env bash

. /etc/bash_completion.d/git-prompt

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

cd "$1" || exit; __git_ps1