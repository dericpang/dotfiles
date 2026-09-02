# Aliases.
alias ll="ls -lhA"
alias grep="grep --color=auto"
alias e="nvim"

# ls colors.
export CLICOLOR=1
export LSCOLORS=ExExExExExEgedabagacad
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}

export PATH=/usr/local/cuda/bin:$HOME/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

eval "$(/home/deric/.local/bin/mise activate zsh)"

# bun completions
[ -s "/home/deric/.bun/_bun" ] && source "/home/deric/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# History settings.
export HISTFILE=~/.bash_history
export HISTSIZE=1000000000       # Load most recent 1,000,000,000 lines
export SAVEHIST=1000000000       # Save most recent 1,000,000,000 lines
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# A forwarded SSH agent socket dies with the connection that created it, so
# panes in a long-lived tmux session end up pointing at a dead socket and lose
# agent auth (git push, and anything an agent running in there shells out to).
# Point every shell at one stable path instead, and re-aim that path whenever a
# fresh connection brings in a live socket. Panes that predate this need
# `export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock` once; after that they self-heal.
if [[ -S $SSH_AUTH_SOCK && $SSH_AUTH_SOCK != $HOME/.ssh/ssh_auth_sock ]]; then
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
fi
[[ -L $HOME/.ssh/ssh_auth_sock ]] && export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

# Function that creates a new tmux session named `main` or attaches to the
# `main` session if it exists.
main() { tmux new-session -A -s ${1:-main} }

nvm use default --silent

# >>> hw-tools modules >>>
# lmod defines the `module` function from /etc/profile.d, which bash only
# sources for LOGIN shells. Source it explicitly so `module` also exists in
# plain interactive shells — and crucially BEFORE `module use` runs.
if ! command -v module >/dev/null 2>&1; then
  for _lmod_init in /etc/profile.d/lmod.sh /etc/profile.d/z00_lmod.sh \
                    /usr/share/lmod/lmod/init/bash; do
    if [ -f "$_lmod_init" ]; then . "$_lmod_init"; break; fi
  done
  unset _lmod_init
fi
if command -v module >/dev/null 2>&1 && [ -d /mnt/hw/tools/modulefiles ]; then
  module use /mnt/hw/tools/modulefiles
  # Default redwood toolchain. Non-fatal: a machine missing one of these must
  # still get a working shell, so failures are swallowed rather than surfaced.
  module load gcc/15.2.0 systemc verilator/5.046 peakrdl bender anvil \
              scc_gcc arcmodel 2>/dev/null || true
fi
# redwood's src/lake/Bender.yml substitutes $VCS_HOME/etc/uvm-1.2 when bender
# PARSES the manifest, before it selects a target — so bender aborts if the
# variable is merely undefined. The verilator targets never read those UVM
# sources, so any value works. STOPGAP: the real fix is to drop that reference
# from Bender.yml; remove this line once that lands.
: "${VCS_HOME:=/mnt/hw/tools/.no-vcs}"; export VCS_HOME
# <<< hw-tools modules <<<
