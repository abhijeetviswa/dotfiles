DOTFILES_DIR=$(shell realpath .)

default:
	@echo "Run 'make install' to install dotfiles"

install: install-nvim

install-nvim: 
	@echo "Installing Neovim config"
	ln -fs "$(DOTFILES_DIR)/config/nvchad" "$$HOME/.config/nvim" 
	ln -fs   "$(DOTFILES_DIR)/config/nvchad-custom" "$$HOME/.config/nvim/lua/custom"

install-tmux:
	@echo "Installing tmux config"
