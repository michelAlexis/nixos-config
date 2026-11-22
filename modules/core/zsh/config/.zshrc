# History
HISTFILE="$XDG_STATE_HOME/zsh_history"
[[ -z "$XDG_STATE_HOME" ]] && HISTFILE="$HOME/.local/state/zsh_history"
mkdir -p "${HISTFILE:h}"
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Completion
autoload -Uz compinit && compinit

# Options
setopt AUTO_CD INTERACTIVE_COMMENTS

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias nrs='sudo nixos-rebuild switch --flake ~/nixos-config#nixos-btw'
alias nup='sudo nix flake update --flake ~/nixos-config'

# Prompt
eval "$(starship init zsh)"
