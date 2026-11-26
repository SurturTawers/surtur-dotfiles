# Homebrew PHP
export PATH="/opt/homebrew/opt/php/bin:/opt/homebrew/opt/php/sbin:$PATH"

# User binaries (Claude Code, Antigravity, Atlas CLI, ...)
export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.antigravity/antigravity/bin" ] && export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
[ -d "$HOME/.antigravity-ide/antigravity-ide/bin" ] && export PATH="$HOME/.antigravity-ide/antigravity-ide/bin:$PATH"

# Private, machine-local settings: SSH shortcuts, VPN, server variables.
# Not tracked in this repo (see README > Private files).
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

eval "$(oh-my-posh init zsh --config $HOME/.ohmybash.omp.json)"

# nvm: put the default Node on PATH now, load nvm itself on first use (faster startup)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
if [ -d "$NVM_DIR/versions/node" ]; then
  _nvm_want=$(<"$NVM_DIR/alias/default" 2>/dev/null); _nvm_want=${_nvm_want#v}
  _nvm_dirs=()
  [[ $_nvm_want == [0-9]* ]] && _nvm_dirs=("$NVM_DIR"/versions/node/v${_nvm_want}*(N/n))
  (( ${#_nvm_dirs} )) || _nvm_dirs=("$NVM_DIR"/versions/node/v*(N/n))
  (( ${#_nvm_dirs} )) && export PATH="${_nvm_dirs[-1]}/bin:$PATH"
  unset _nvm_want _nvm_dirs
fi
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  nvm "$@"
}

# Completions (Docker CLI completions first, then a single compinit)
[ -d "$HOME/.docker/completions" ] && fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit && compinit

# lazygit: read config from dotfiles (~/.config/lazygit -> dotfiles/macos/.config/lazygit)
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml"
