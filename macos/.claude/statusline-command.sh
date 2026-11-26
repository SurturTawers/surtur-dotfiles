#!/bin/bash
# Claude Code status line - mirrors the oh-my-posh theme in $HOME/.ohmybash.omp.json
# (path / language / git / os / user@host segments), skipping optional git locks.

input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
[ -d "$cwd" ] || cwd="$PWD"

RESET="\033[0m"
PATH_FG="\033[38;2;100;162;250m"   # #64A2FA
ANGULAR_FG="\033[38;2;233;3;100m"  # #E90364
PHP_FG="\033[38;2;135;137;222m"    # #8789de
NODE_FG="\033[38;2;108;163;94m"    # #6CA35E
OS_FG="\033[38;2;231;83;32m"       # #E75320
GIT_FG="\033[38;2;219;219;219m"    # #DBDBDB
USER_FG="\033[38;2;172;176;190m"   # #ACB0BE (palette "os"/"closer")
SEP_FG="\033[38;2;180;190;254m"    # #B4BEFE (palette "lavender")

# --- path segment (agnoster_short style: ~ for home, last 2 dirs) ---
display_path="$cwd"
case "$display_path" in
  "$HOME"/*) display_path="~${display_path#$HOME}" ;;
  "$HOME") display_path="~" ;;
esac
IFS='/' read -ra parts <<< "$display_path"
n=${#parts[@]}
if [ "$n" -gt 2 ]; then
  short_path=".../${parts[$((n-2))]}/${parts[$((n-1))]}"
else
  short_path="$display_path"
fi
path_segment=$(printf "${PATH_FG} %s${RESET}" "$short_path")

# --- language segments (only shown when the project uses them) ---
lang_segment=""
if [ -f "$cwd/angular.json" ] && command -v ng >/dev/null 2>&1; then
  ver=$(ng version 2>/dev/null | grep -m1 "Angular CLI" | awk '{print $NF}')
  [ -n "$ver" ] && lang_segment="${lang_segment}$(printf " ${ANGULAR_FG} %s${RESET}" "$ver")"
fi
if [ -f "$cwd/composer.json" ] && command -v php >/dev/null 2>&1; then
  ver=$(php -r 'echo PHP_VERSION;' 2>/dev/null)
  [ -n "$ver" ] && lang_segment="${lang_segment}$(printf " ${PHP_FG} %s${RESET}" "$ver")"
fi
if [ -f "$cwd/package.json" ] && command -v node >/dev/null 2>&1; then
  ver=$(node --version 2>/dev/null)
  [ -n "$ver" ] && lang_segment="${lang_segment}$(printf " ${NODE_FG} %s${RESET}" "$ver")"
fi

# --- git segment: upstream ahead/behind, git user, HEAD, working tree state ---
git_segment=""
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  if [ -z "$branch" ]; then
    branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
  fi
  git_user=$(git -C "$cwd" --no-optional-locks config user.name 2>/dev/null)

  upstream_icon=""
  upstream=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
  if [ -n "$upstream" ]; then
    ahead_behind=$(git -C "$cwd" --no-optional-locks rev-list --left-right --count HEAD..."$upstream" 2>/dev/null)
    ahead=$(echo "$ahead_behind" | awk '{print $1}')
    behind=$(echo "$ahead_behind" | awk '{print $2}')
    [ "${ahead:-0}" != "0" ] && upstream_icon="${upstream_icon}${ahead} "
    [ "${behind:-0}" != "0" ] && upstream_icon="${upstream_icon}${behind} "
  fi

  status=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
  if [ -z "$status" ]; then
    working=""
  else
    count=$(echo "$status" | wc -l | tr -d ' ')
    working=" ${count}"
  fi

  git_segment=$(printf " ${GIT_FG}%b%s  %s %b${RESET}" "$upstream_icon" "$git_user" "$branch" "$working")
fi

# --- os + user@host segment ---
uname_s=$(uname -s)
case "$uname_s" in
  Darwin) os_icon="" ;;
  Linux) os_icon="" ;;
  *) os_icon="" ;;
esac
user=$(whoami)
host=$(hostname -s)
os_segment=$(printf " ${OS_FG}%b ${RESET} ${USER_FG}%s@%s${RESET}" "$os_icon" "$user" "$host")

sep=$(printf " ${SEP_FG}${RESET} ")

printf "%b%b%b%b%b" "$path_segment" "$lang_segment" "$git_segment" "$sep" "$os_segment"
