#!/bin/sh
# New Claude agent window for a task: session "agents", window named after the task,
# working directory ~/kastor/sigmund, Claude started in a shell (exiting Claude keeps the shell).
# If a window with that name already exists, switch to it instead.
#
#   agent-new.sh "<task name>"     (bound to prefix C, which prompts for the name)
#
# TMUX_AGENT_DIR / TMUX_AGENT_CMD override the folder / command (used for testing).

session=agents
dir=${TMUX_AGENT_DIR:-$HOME/kastor/sigmund}
cmd=${TMUX_AGENT_CMD:-claude}

# window names become tmux targets: keep letters, digits, - and _
name=$(printf '%s' "$1" | tr -cs 'A-Za-z0-9_-' '-' | sed 's/^-*//; s/-*$//')
[ -n "$name" ] || { tmux display-message "agent-new: empty task name"; exit 0; }
[ -d "$dir" ] || { tmux display-message "agent-new: $dir not found"; exit 0; }

if ! tmux has-session -t "=$session" 2>/dev/null; then
  tmux new-session -d -s "$session" -n "$name" -c "$dir"
  tmux send-keys -t "=$session:=$name" "$cmd" Enter
elif ! tmux list-windows -t "=$session" -F '#{window_name}' | grep -qx "$name"; then
  tmux new-window -d -t "=$session:" -n "$name" -c "$dir"
  tmux send-keys -t "=$session:=$name" "$cmd" Enter
fi

tmux switch-client -t "=$session:=$name"
