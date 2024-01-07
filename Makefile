DOTFILES_DIR:=$(shell realpath .)

# ## FIND OS
UNAME:=$(shell uname)

# ## OS SPECIFIC DECLARATIONS
# ### LINUX
ifeq ($(UNAME), Linux)
	LN?="/bin/ln"
endif

# ### DARWIN
ifeq ($(UNAME), Darwin)
	LN?=/usr/local/bin/gln
endif

default:
	@echo "Run 'make install' to install dotfiles"

.PHONY: install
install: install-nvim

.PHONY: install-nvim
install-nvim:
	@echo "Installing Neovim config"
	$(LN) -fTs  "$(DOTFILES_DIR)/config/nvim/nvchad" "$$HOME/.config/nvim"
	$(LN) -fTs "$(DOTFILES_DIR)/config/nvim/custom" "$$HOME/.config/nvim/lua/custom"
	$(LN) -fTs "$(DOTFILES_DIR)/config/nvim/snippets" "$$HOME/.config/nvim/vscode-snippets"

.PHONY: install-tmux
install-tmux:
	@echo "Installing tmux config"
	# Single file config
	$(LN) -fTs "$(DOTFILES_DIR)/config/tmux/tmux.conf" "$$HOME/.config/tmux/tmux.conf"
