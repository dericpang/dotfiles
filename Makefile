pwd := $(shell pwd -LP)

.PHONY: macos ubuntu vim nvim git ssh ssh-config shared vscode cursor

macos: shared vscode cursor ssh-config
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

git: ssh
	@ln -nfs "${pwd}/gitconfig" "$(HOME)/.gitconfig"
	@ln -nfs "${pwd}/gitconfig-architect" "$(HOME)/.gitconfig-architect"
	@ln -nfs "${pwd}/gitconfig-nullprior" "$(HOME)/.gitconfig-nullprior"
	@ln -nfs "${pwd}/gitconfig-dericpang" "$(HOME)/.gitconfig-dericpang"

ssh:
	@mkdir -p "$(HOME)/.ssh"
	@ln -nfs "${pwd}/ssh/rc" "$(HOME)/.ssh/rc"

# macOS only: the config uses UseKeychain, which Linux OpenSSH rejects.
ssh-config: ssh
	@ln -nfs "${pwd}/ssh/config.macos" "$(HOME)/.ssh/config"

shared: vim nvim git
	@ln -nfs "${pwd}/bin" "$(HOME)/bin"
	@ln -nfs "${pwd}/tmux.conf" "$(HOME)/.tmux.conf"
	@if [ ! -d "$(HOME)/.config/ranger" ]; then mkdir -p "$(HOME)/.config/ranger"; fi && ln -nfs "${pwd}/rc.config" "$(HOME)/.config/ranger/rc.conf"
