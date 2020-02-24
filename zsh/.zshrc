# Prompt (adapted from Parth Mehrotra)
autoload -U colors && colors
setopt PROMPT_SUBST # Enable command substitution
set_prompt() {
	# shows virtualenv name if activated, and [ always
    ZSH_THEME_VIRTUALENV_PREFIX="["
    ZSH_THEME_VIRTUALENV_SUFFIX="]"
	PS1="%{$fg[green]%}$(virtualenv_prompt_info)%{$reset_color%}% ["

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

# Completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
# Next 3 functions taken from (https://github.com/LukeSmithxyz/voidrice)
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[2 q' # 2 is solid block

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q' # 6 is solid cursor
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    zle -K viins
    echo -ne "\e[6 q"
}
zle -N zle-line-init

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
bindkey -s '^o' 'lfcd\n'

# Source plugins
source /usr/local/etc/profile.d/z.sh
source ~/dotfiles/zsh/ohmyzsh/plugins/git/git.plugin.zsh
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/fixls.zsh
source ~/dotfiles/zsh/ohmyzsh/plugins/virtualenv/virtualenv.plugin.zsh

# Aliases
alias ll="ls -al"
alias attu="ssh lucianod@attu.cs.washington.edu"
alias v="vim -p"
alias python=python3
alias pip=pip3
alias jl="jupyter lab"
alias hg="history 1|grep "

# System variables, mainly to make pip work properly
export CPATH=/Library/Developer/CommandLineTools/usr/include/c++/v1
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PATH="/usr/local/opt/sqlite/bin:$PATH":$PATH
export VISUAL=vim   # Default to vim editor
chpwd() ls          # Always ls after cd
export VIRTUAL_ENV_DISABLE_PROMPT=1
