#!/usr/bin/env bash

set -Eeo pipefail

START_DIR=~/Development/scx/customer-website-frontend
SESSION_NAME="scx"

create_session() {
  set -- "$(stty size)" # $1 = rows $2 = columns
  tmux new-session -d -s $SESSION_NAME -x "$2" -y "$(($1 - 1))" -c "$START_DIR"
}

create_window() {
  local num=$1
  local cmd=$2
  local window_name="$SESSION_NAME:$num"

  tmux new-window -t "$window_name"
  tmux select-window -t "$window_name"

  tmux send-keys "$cmd" C-m

}

split_window() {
  tmux split-window "$@"
}

create_session

# Frontend Window
create_window 1 npm run dev
# split window



# tmux split-window -h -t "$PROJECT_NAME" -n "frontend"
