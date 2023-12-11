DOTFILES_DIR=$(shell realpath .)

default:
	@echo "Run 'make install' to install dotfiles"

install: install-nvim

install-nvim:
	@echo "Installing Neovim config"
	ln -fs "$(DOTFILES_DIR)/config/nvim/nvchad" "$$HOME/.config/nvim"
	ln -fs   "$(DOTFILES_DIR)/config/nvim/custom" "$$HOME/.config/nvim/lua/custom"
	ln -fs   "$(DOTFILES_DIR)/config/nvim/snippets" "$$HOME/.config/nvim/snippets"

install-tmux:
	@echo "Installing tmux config"
