# Bash on macOS. zsh is the login shell; this covers occasional bash sessions.

# Only for interactive shells
case $- in
  *i*) ;;
  *) return ;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend checkwinsize

[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"

command -v oh-my-posh >/dev/null && eval "$(oh-my-posh init bash --config ~/.ohmybash.omp.json)"
