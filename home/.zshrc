

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
command -v jenv >/dev/null && eval "$(jenv init -)"

# Plugins
if command -v brew >/dev/null; then
  BREW_PREFIX="$(brew --prefix)"
  [ -r "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  [ -r "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  unset BREW_PREFIX
fi

# Keybinding: accept suggestion with Ctrl+F
bindkey '^f' autosuggest-accept

# Aliases
alias up="cd .."
alias add="git add ."
alias push="git push"
alias pull="git pull"
alias m="git switch main"
alias cc="claude --permission-mode auto"
alias co="codex"

# Starship initialization
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"
command -v starship >/dev/null && eval "$(starship init zsh)"
