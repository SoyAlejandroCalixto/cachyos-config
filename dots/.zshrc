eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias vim=nvim
alias rcat=/usr/bin/cat
alias cat=bat
alias rls=/usr/bin/ls
alias ls=lsd

eval "$(starship init zsh)"

eval "$(mise activate zsh)"
