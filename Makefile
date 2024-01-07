DOTFILES_DIR=$(shell realpath .)

default:
	@echo "Run 'make install' to install dotfiles"

install: install-nvim

install-nvim:
	@echo "Installing Neovim config"
	gln -fs "$(DOTFILES_DIR)/config/nvim/nvchad" "$$HOME/.config/nvim"
	gln -fs   "$(DOTFILES_DIR)/config/nvim/custom" "$$HOME/.config/nvim/lua/custom"
	gln -fs   "$(DOTFILES_DIR)/config/nvim/snippets" "$$HOME/.config/nvim/vscode-snippets"

install-tmux:
	@echo "Installing tmux config"
