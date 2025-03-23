# +-----------+
# |  Options |
# +-----------+
setopt correct
HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

# +--------------+
# |  Environment |
# +--------------+
# --- Init Vars ---
export UNAME="$(uname)"
export ZSH="$DOTFILES_DIR/config/zsh/ohmyzsh"
export ZSH_CUSTOM="$DOTFILES_DIR/config/zsh/custom"
export ZSH_THEME="powerlevel10k/powerlevel10k"

# --- Miscellaneous --
export EDITOR="nvim"
export PAGER="bat"
export GPG_TTY=$TTY
export KEYTIMEOUT=1
export MAKEFLAGS="-j $(nproc 2>/dev/null || echo 1)"

# +---------+
# | Aliases |
# +---------+
alias cat=bat
alias vim=nvim
alias dotfiles="nvim $DOTFILES_DIR"
alias zshrc="nvim $DOTFILES_DIR/config/zsh/config/.zshrc"

if [[ "$UNAME" == "Linux" ]]; then
  source "$DOTFILES_DIR/config/zsh/config/zshenv.linux"
elif [[ "$UNAME" == "Darwin" ]]; then
  source "$DOTFILES_DIR/config/zsh/config/zshenv.darwin"
fi

source "$DOTFILES_DIR/config/zsh/config/zshenv.local"
