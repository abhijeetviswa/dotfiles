# +-----------+
# |  Options |
# +-----------+
setopt correct

# +--------------+
# |  Environment |
# +--------------+
# --- Init Vars ---
export UNAME="$(uname)"
export DOTFILES_DIR=$(realpath "$(dirname "${0:a}")/../../..")
export ZSH="$DOTFILES_DIR/config/zsh/ohmyzsh"
export ZSH_CUSTOM="$DOTFILES_DIR/config/zsh/custom"
export ZSH_THEME="powerlevel10k/powerlevel10k"

# --- Miscellaneous --
export EDITOR="nvim"
export PAGER="bat"
export GPG_TTY=$TTY
export KEYTIMEOUT=1
export LS_COLORS="$(vivid generate one-dark || echo '') > /dev/null"
export MAKEFLAGS="-j $(nproc)"

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
