DOTFILES_DIR:=$(shell realpath .)
UNAME:=$(shell uname)

# +--------------------------+
# | OS SPECIFIC DECLARATIONS |
# +--------------------------+
# --- LINUX ---
ifeq ($(UNAME), Linux)
	LN?="/bin/ln"
	PKGMGR=pacman -Syu
endif

# --- DARWIN ---
ifeq ($(UNAME), Darwin)
	LN?=$(shell brew --prefix)/bin/gln
	PKGMGR?=brew install
endif

default:
	@echo "Run 'make install' to install dotfiles"

.PHONY: install-common
install-common:
	@echo "Installing common software"
	$(PKGMGR) fzf python3 bat ripgrep jq yamlfmt git nvim tmux wezterm
	pip3 install --user --break-system-packages libtmux

.PHONY: install-zsh
install-zsh:
	@echo "Installing Zsh config"
	mv $$HOME/.zshenv $$HOME/.zshenv.bak
	echo 'export ZDOTDIR="$(DOTFILES_DIR)/config/zsh/config"' | cat >> $$HOME/.zshenv
	echo 'export DOTFILES_DIR="$(DOTFILES_DIR)"' | cat >> $$HOME/.zshenv
	echo 'source $(DOTFILES_DIR)/config/zsh/config/.zshenv' | cat >> $$HOME/.zshenv

.PHONY: install-nvim
install-nvim:
	@echo "Installing Neovim config"
	$(LN) -fTs  "$(DOTFILES_DIR)/config/nvim" "$$HOME/.config/nvim"

.PHONY: install-tmux
install-tmux:
	@echo "Installing tmux config"
	# Single file config
	mkdir -p "$$HOME/.config/tmux/"
	$(LN) -fTs "$(DOTFILES_DIR)/config/tmux/tmux.conf" "$$HOME/.config/tmux/tmux.conf"
	git clone "https://github.com/tmux-plugins/tpm" "$$HOME/.config/tmux/plugins/tpm"

.PHONY: install-yamlfmt
install-yamlfmt:
	mkdir -p "$$HOME/.config/yamlfmt/"
	$(LN) -fTs "$(DOTFILES_DIR)/config/yamlfmt/yamlfmt.yml" "$$HOME/.config/yamlfmt/yamlfmt.yml"


install-wezterm:
	mkdir -p "$$HOME/.config/wezterm/"
	$(LN) -fTs "$(DOTFILES_DIR)/config/wezterm/wezterm.lua" "$$HOME/.config/wezterm/wezterm.lua"

.PHONY: config-git
	@echo "Configuring git"
	git config --global merge.conflictStyle zdiff3
	git config --global rebase.autoSquash true
	git config --global push.default current
	git config --global rerere.eanbled true
	git config --global commit.verbose true
	git config --help.autoCorrect prompt
	git config --force-if-icnludes true


.PHONY: install
install: install-common install-zsh install-nvim install-tmux config-git

