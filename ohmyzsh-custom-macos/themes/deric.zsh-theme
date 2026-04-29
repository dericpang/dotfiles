NEWLINE=$'\n'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%})"

function virtualenv_prompt_info() {
  [[ -n "$VIRTUAL_ENV" ]] && echo "%{$fg[cyan]%}(${VIRTUAL_ENV:t})%{$reset_color%} "
}

PROMPT='$(virtualenv_prompt_info)%{$fg[white]%}%n%{$fg[magenta]%}@%{$fg[yellow]%}%m%{$fg[blue]%}:%~ $(git_prompt_info) ${NEWLINE}%{$reset_color%}$ '
