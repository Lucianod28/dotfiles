autoload -U colors && colors # Make colors callable by name

# Source plugins
autoload -Uz compinit
compinit
source /usr/local/etc/profile.d/z.sh
source ~/dotfiles/zsh/ohmyzsh/plugins/git/git.plugin.zsh
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/fixls.zsh

# Load plugins
plugins=(
    git
    z
    zsh-syntax-highlighting
)

# Prompt (adapted from Parth Mehrotra)
setopt PROMPT_SUBST # Enable command substitution
set_prompt() {

	# [
	PS1="["

	PS1+="%{$fg_bold[cyan]%}%80<..<%~%{$reset_color%}"

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
precmd_functions+=set_prompt


# Aliases
alias ll="ls -al"
alias attu="ssh lucianod@attu.cs.washington.edu"
alias cs="cd ~/Google\ Drive/Documents/University\ of\ Washington/Computer\ Science/"
alias f="vim -p"
alias python=python3
alias pip=pip3
alias jl="jupyter lab"

# System variables, mainly to make pip work properly
export CPATH=/Library/Developer/CommandLineTools/usr/include/c++/v1
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PATH="/usr/local/opt/sqlite/bin:$PATH":$PATH
export VISUAL=vim   # Default to vim editor
chpwd() ls          # Always ls after cd
