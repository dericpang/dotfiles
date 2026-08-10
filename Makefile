pwd := $(shell pwd -LP)

.PHONY: macos ubuntu vim nvim git ssh graphite shared vscode cursor

macos: shared vscode cursor
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
	@ln -nfs "${pwd}/ssh/jisoo.pub" "$(HOME)/.ssh/jisoo.pub"
	@ln -nfs "${pwd}/ssh/deric-architect.pub" "$(HOME)/.ssh/deric-architect.pub"

# Scaffolds an alternate Graphite config dir (for the dericpang account). The gt
# wrapper in zshrc points here when inside ~/dericpang, ~/dotfiles, ~/nullprior.
# aliases/user_config are shared with the default account; the secret auth token
# is set separately with: gt auth --token <token>  (run from one of those dirs).
graphite:
	@mkdir -p "$(HOME)/.graphite-envs/dericpang/graphite"
	@[ -f "$(HOME)/.config/graphite/aliases" ] && ln -nfs "$(HOME)/.config/graphite/aliases" "$(HOME)/.graphite-envs/dericpang/graphite/aliases" || true
	@[ -f "$(HOME)/.config/graphite/user_config" ] && ln -nfs "$(HOME)/.config/graphite/user_config" "$(HOME)/.graphite-envs/dericpang/graphite/user_config" || true

shared: vim nvim git graphite
	@ln -nfs "${pwd}/bin" "$(HOME)/bin"
	@ln -nfs "${pwd}/tmux.conf" "$(HOME)/.tmux.conf"
	@if [ ! -d "$(HOME)/.config/ranger" ]; then mkdir -p "$(HOME)/.config/ranger"; fi && ln -nfs "${pwd}/rc.config" "$(HOME)/.config/ranger/rc.conf"
