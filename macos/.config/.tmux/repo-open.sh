#!/bin/sh
# Open a repo in session "repos": switch to its window if open, otherwise create it
# (window named after the repo, working directory = the repo).
#
#   repo-open.sh            fuzzy-pick a repo (bound to prefix o, runs in a popup)
#   repo-open.sh <path>     open that folder directly
#
# Repos offered: git repos directly under ~/kastor and ~/daps, plus ~/dotfiles.
# TMUX_REPO_ROOTS (space-separated) overrides the folders searched (used for testing).

session=repos
roots=${TMUX_REPO_ROOTS:-"$HOME/kastor $HOME/daps"}

list_repos() {
  for root in $roots; do
    for d in "$root"/*/; do
      [ -e "$d.git" ] && printf '%s\n' "${d%/}"
    done
  done
  [ -z "$TMUX_REPO_ROOTS" ] && [ -e "$HOME/dotfiles/.git" ] && printf '%s\n' "$HOME/dotfiles"
}

if [ -n "$1" ]; then
  path=$1
else
  fzf=$(command -v fzf || echo /opt/homebrew/bin/fzf)
  path=$(list_repos | sed "s|^$HOME|~|" | sort |
    "$fzf" --prompt 'repo> ' --height 100% --reverse \
      --preview 'git -C "$(echo {} | sed "s|^~|$HOME|")" log --oneline --color=always -12' \
      --preview-window 'right,55%')
  [ -n "$path" ] || exit 0
  path=$(printf '%s' "$path" | sed "s|^~|$HOME|")
fi
[ -d "$path" ] || { tmux display-message "repo-open: $path not found"; exit 0; }

name=$(basename "$path" | tr -cs 'A-Za-z0-9_-' '-' | sed 's/-*$//')

if ! tmux has-session -t "=$session" 2>/dev/null; then
  tmux new-session -d -s "$session" -n "$name" -c "$path"
elif ! tmux list-windows -t "=$session" -F '#{window_name}' | grep -qx "$name"; then
  tmux new-window -d -t "=$session:" -n "$name" -c "$path"
fi

tmux switch-client -t "=$session:=$name"
