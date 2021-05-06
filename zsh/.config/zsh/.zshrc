# Autocomplete
autoload -Uz compinit
zstyle ':completion:*' menu select
# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
compinit
_comp_options+=(globdots)

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/history"

[ -f $ZDOTDIR/zsh-aliases ] && source "$ZDOTDIR/zsh-aliases"
[ -f $ZDOTDIR/zsh-prompt ] && source "$ZDOTDIR/zsh-prompt"
[ -f $ZDOTDIR/zsh-keybinds ] && source "$ZDOTDIR/zsh-keybinds"
[ -f $ZDOTDIR/zsh-vi-mode ] && source "$ZDOTDIR/zsh-vi-mode"

# Version managers
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v jenv 1>/dev/null 2>&1; then
  eval "$(jenv init -)"
fi

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
