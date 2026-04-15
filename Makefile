pwd := $(shell pwd -LP)

.PHONY: macos ubuntu vim nvim git shared vscode cursor

macos: shared vscode
	@ln -nfs "${pwd}/alacritty" "$(HOME)/.config/alacritty"
	@ln -nfs "${pwd}/zshrc.macos" "$(HOME)/.zshrc"
	@ln -nfs "${pwd}/bashrc.macos" "$(HOME)/.bashrc"

ubuntu: shared
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
	@ln -nfs "${pwd}/gitconfig-architect" "$(HOME)/.gitconfig-architect"

shared: vim nvim git
	@ln -nfs "${pwd}/bin" "$(HOME)/bin"
	@ln -nfs "${pwd}/tmux.conf" "$(HOME)/.tmux.conf"
	@if [ ! -d "$(HOME)/.config/ranger" ]; then mkdir -p "$(HOME)/.config/ranger"; fi && ln -nfs "${pwd}/rc.config" "$(HOME)/.config/ranger/rc.conf"
