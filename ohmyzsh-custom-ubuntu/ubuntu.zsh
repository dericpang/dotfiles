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

# Function that creates a new tmux session named `main` or attaches to the
# `main` session if it exists.
main() { tmux new-session -A -s ${1:-main} }

nvm use default --silent
