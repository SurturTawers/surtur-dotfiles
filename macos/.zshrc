#export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
#export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
export PATH="/opt/homebrew/opt/php/bin:$PATH"
export PATH="/opt/homebrew/opt/php/sbin:$PATH"
autoload -Uz compinit && compinit

#EXPORT THE SERVER IP VARIABLES AND USE IT ON ALIASES
input="$HOME/.servers"
while IFS= read -r line
do
  export "${line%=*}"="${line#*=}"
done < "$input"

eval "$(oh-my-posh init zsh --config $HOME/.ohmybash.omp.json)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
