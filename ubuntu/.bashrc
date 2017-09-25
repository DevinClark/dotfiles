
export EDITOR="subl -w"

# Create a new directory and enter it
function md() {
  mkdir -p "$@" && cd "$@"
}

if [[ -e ~/.ssh/known_hosts ]]; then
  complete -o default -W "$(cat ~/.ssh/known_hosts | sed 's/[, ].*//' | sort | uniq | grep -v '[0-9]')" ssh scp sftp
fi
