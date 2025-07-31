export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
#export PATH="/opt/homebrew/opt/php/bin:$PATH"
#export PATH="/opt/homebrew/opt/php/sbin:$PATH"
autoload -Uz compinit && compinit

#EXPORT THE SERVER IP VARIABLES AND USE IT ON ALIASES
input="$HOME/.servers"
while IFS= read -r line
do
  export "${line%=*}"="${line#*=}"
done < "$input"

alias ck2="ssh -i ~/.ssh/k2keydt dtorres@${K2_IP}"
alias cfenix="ssh dtorres@${FENIX_IP}"

alias csisyphus_dev_ec2="ssh -i ~/.ssh/sisyphus-dev-masterkey.pem ec2-user@${SISYPHUS_DEV_IP}"
alias csisyphus_dev_dtorres="ssh -i ~/.ssh/sisyphus-dev-dtorreskey.pem dtorres@${SISYPHUS_DEV_IP}"

alias csisyphus_prod_ec2="ssh -i ~/.ssh/sisyphus-prod-masterkey.pem ec2-user@${SISYPHUS_PROD_IP}"
alias csisyphus_prod_dtorres="ssh -i ~/.ssh/sisyphus-prod-dtorreskey.pem dtorres@${SISYPHUS_PROD_IP}"

eval "$(oh-my-posh init zsh --config $HOME/.ohmybash.omp.json)"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export OPENAI_API_KEY="$(cat ~/.openapitoken)";
export GEMINI_API_KEY="$(cat ~/.geminiapitoken)";
