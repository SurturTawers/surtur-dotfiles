#!/bin/sh
# Claude Code hook -> tmux: marks the tmux window running a Claude session with its state,
# shown as an icon in the status bar (see .tmux.catppuccin.conf).
#
#   claude-status.sh working   prompt submitted                       (UserPromptSubmit)
#   claude-status.sh resume    tool ran; back to working if it was waiting  (PostToolUse)
#   claude-status.sh notify    needs approval/input; rings the bell   (Notification)
#   claude-status.sh done      finished its turn, ready for review    (Stop)
#   claude-status.sh clear     session started/ended                  (SessionStart/SessionEnd)
#
# Does nothing outside tmux. Always exits 0 so it can never block Claude.

[ -n "$TMUX_PANE" ] || exit 0
command -v tmux >/dev/null 2>&1 || exit 0

get_state() { tmux show-options -wqv -t "$TMUX_PANE" @claude_state 2>/dev/null; }
set_state() { tmux set-option -wq -t "$TMUX_PANE" @claude_state "$1" 2>/dev/null; }

case "$1" in
  working)
    set_state working
    ;;
  resume)
    [ "$(get_state)" = waiting ] && set_state working
    ;;
  notify)
    # Claude also sends idle reminders after it finished; keep those as "done"
    [ "$(get_state)" = done ] && exit 0
    set_state waiting
    # ring the bell from the Claude pane so tmux flags the window (and Ghostty can alert)
    tty=$(tmux display-message -p -t "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
    [ -n "$tty" ] && [ -w "$tty" ] && printf '\a' >"$tty"
    ;;
  done)
    set_state done
    ;;
  clear)
    tmux set-option -wqu -t "$TMUX_PANE" @claude_state 2>/dev/null
    ;;
esac
exit 0
