pwd := $(shell pwd -LP)

.PHONY: macos ubuntu vim nvim git shared vscode cursor

figmamacos: shared
	@ln -nfs "${pwd}/alacritty" "$(HOME)/.config/alacritty"
	@ln -nfs "${pwd}/zshrc.macos" "$(HOME)/.zshrc"
	@ln -nfs "${pwd}/bashrc.macos" "$(HOME)/.bashrc"
	cd figma-dotfiles && make macos

figmalinux: shared
	@ln -nfs "${pwd}/bashrc.ubuntu" "$(HOME)/.bashrc"
	@ln -nfs "${pwd}/zshrc.ubuntu" "$(HOME)/.zshrc"
	cd figma-dotfiles && make linux

googlemacos:
	cd google-dotfiles && make macos

googlelinux:
	cd google-dotfiles && make linux

macos: shared git vscode
	@ln -nfs "${pwd}/alacritty" "$(HOME)/.config/alacritty"
	@ln -nfs "${pwd}/zshrc.macos" "$(HOME)/.zshrc"
	@ln -nfs "${pwd}/bashrc.macos" "$(HOME)/.bashrc"

ubuntu: shared git
	@ln -nfs "${pwd}/zshrc.ubuntu" "$(HOME)/.zshrc"
	@ln -nfs "${pwd}/bashrc.ubuntu" "$(HOME)/.bashrc"

vim:
	cd vim && make link

nvim:
	cd nvim && make link

vscode:
	@ln -nfs "${pwd}/vscode/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json"
	@ln -nfs "${pwd}/vscode/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json"

cursor:
	@ln -nfs "${pwd}/vscode/settings.json" "$(HOME)/Library/Application Support/Cursor/User/settings.json"
	@ln -nfs "${pwd}/vscode/keybindings.json" "$(HOME)/Library/Application Support/Cursor/User/keybindings.json"

git:
	@ln -nfs "${pwd}/gitconfig" "$(HOME)/.gitconfig"

shared: vim nvim
	@ln -nfs "${pwd}/bin" "$(HOME)/bin"
	@ln -nfs "${pwd}/tmux.conf" "$(HOME)/.tmux.conf"
	@if [ ! -d "$(HOME)/.config/ranger" ]; then mkdir -p "$(HOME)/.config/ranger"; fi && ln -nfs "${pwd}/rc.config" "$(HOME)/.config/ranger/rc.conf"
