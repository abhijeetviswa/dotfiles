# +-------------------------------+
# | # oh-my-zsh and powerlevel10k |
# +-------------------------------+
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


plugins=(
  git
  aws
  dirhistory
  docker
  docker-compose
  history
  nvm safe-paste z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_THEME="powerlevel10k/powerlevel10k"

[[ ! -f $DOTFILES_DIR/config/zsh/config/p10k.zsh ]] || source $DOTFILES_DIR/config/zsh/config/p10k.zsh

source $ZSH/oh-my-zsh.sh


# +---------+
# | Widgets |
# +---------+
autoload -z edit-command-line
zle -N edit-command-line

# +-------------------+
# | # Custom Keybinds |
# +-------------------+
bindkey "^X^X" edit-command-line

# +---------+
# | Aliases |
# +---------+
# -- Meant to override oh-my-zsh aliases --
alias gg=lazygit

if [[ $UNAME == "Linux" ]]; then
  source "$DOTFILES_DIR/config/zsh/config/zshrc.linux"
elif [[ $UNAME == "Darwin" ]]; then
  source "$DOTFILES_DIR/config/zsh/config/zshrc.darwin"
fi

source "$DOTFILES_DIR/config/zsh/config/zshrc.local"

source <(kubectl completion zsh)

export PATH="$HOME/.cargo/bin:$PATH"

autoload -Uz compinit && compinit
