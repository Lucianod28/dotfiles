# Prompt (adapted from Parth Mehrotra)
autoload -U colors && colors
setopt PROMPT_SUBST # Enable command substitution
set_prompt() {
	# shows virtualenv name if activated, and [ always
    ZSH_THEME_VIRTUALENV_PREFIX="["
    ZSH_THEME_VIRTUALENV_SUFFIX="]"
	PS1="%{$fg[green]%}$(virtualenv_prompt_info)%{$reset_color%}% ["

	PS1+="%{$fg_bold[cyan]%}%~%{$reset_color%}"

	# Status Code
	PS1+='%(?.., %{$fg[red]%}%?%{$reset_color%})'

 	# Git
 	if git rev-parse --is-inside-work-tree 2> /dev/null | grep -q 'true' ; then
 		PS1+=', '
        PS1+="%{$fg[magenta]%}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%{$reset_color%}"
		STATUS=$(git status --short | wc -l)
		if [ $STATUS -gt 0 ]; then
 			PS1+="%{$fg[green]%}+$(echo $STATUS | awk '{$1=$1};1')%{$reset_color%}"
 		fi
 	fi

	# PID
	if [[ $! -ne 0 ]]; then
		PS1+=', '
		PS1+="%{$fg[yellow]%}PID:$!%{$reset_color%}"
	fi

	# ]
	PS1+="]: "
}
precmd_functions+=(set_prompt)
