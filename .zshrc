# .zshrc

# oh-my-zsh integration, or not
if [ -f "$HOME/.oh-my-zsh.disable" ]; then
	unset ZSH
elif [ -d "$HOME/.oh-my-zsh" ]; then
	export ZSH="$HOME/.oh-my-zsh"
fi
if [ -n "$ZSH" ]; then
	ZSH_THEME=
	plugins=(vi-mode git-prompt kube-ps1)
	if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
		plugins+=zsh-syntax-highlighting
	fi
	zstyle ':omz:update' mode disabled
	source "$ZSH/oh-my-zsh.sh"
	P_MARK='%{$fg_bold[blue]%}∑%{$reset_color%}'
	P_GIT_CMD='$(git_super_status)'
else
	# good enough ZSH without oh-my-zsh
	autoload -U colors && colors
	autoload -U compinit && compinit
	source ~/.zsh-partial-imports/lib/directories.zsh
	source ~/.zsh-partial-imports/lib/history.zsh
	source ~/.zsh-partial-imports/lib/key-bindings.zsh
	source ~/.zsh-partial-imports/lib/completion.zsh
	source ~/.zsh-partial-imports/vi-mode/vi-mode.plugin.zsh
	source ~/.zsh-partial-imports/kube-ps1/kube-ps1.plugin.zsh
	source ~/.zsh-partial-imports/woefe-git-prompt/git-prompt.zsh
	alias ls='ls --color'
	P_MARK='%{$fg_bold[blue]%}:%{$reset_color%}'
	P_GIT_CMD='$(gitprompt)'
	if [ -d /usr/share/zsh-syntax-highlighting ]; then
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
fi
# similar to bash, at least required at by ssh-reagent
setopt NO_NOMATCH # on: if no matches in glob delete the pattern and gives no errors

# Shell management
omz-install() { git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh }
omz-uninstall() { rm -rf ~/.oh-my-zsh }
omz-install-highlighting() {
	if [ -d /usr/share/zsh-syntax-highlighting ]; then
		# debian zsh-syntax-highlighting package
		mkdir -p ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
		ln -sv /usr/share/zsh-syntax-highlighting/highlighters/ ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
		ln -sv /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
		printf "%s\n%s" '0=${(%):-%N}' 'source ${0:A:h}/zsh-syntax-highlighting.zsh' > ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
	else
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	fi
}
omz-uninstall-highlighting() { rm -rf ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting }
omz-disable() { touch ~/.oh-my-zsh.disable }
omz-enable() { rm ~/.oh-my-zsh.disable }

# Our own theme. Most ready made had two lines, and if they had return code it was printed to the right side
# We have
# - date
# - workdir
# - git status
# - return code
# Or consider some base theme eg. oliver and add git status
# PROMPT="${PROMPT} $(gitprompt)"
PROMPT='$(kube_ps1)%{$fg_bold[blue]%}%D{%Y-%m-%d %H:%M}%{$reset_color%} %n'"$P_MARK"'%3~'"$P_GIT_CMD"'%(?..|%{$fg_bold[red]%}%?↵%{$reset_color%})%B%#%b '
# for plugins prompt integration
RPROMPT= # disable the right prompt of old git-prompt
ZSH_THEME_GIT_PROMPT_CACHE=y # old git-prompt
VI_MODE_SET_CURSOR=true # change the cursor per the vim mode
ZSH_THEME_GIT_PROMPT_SUFFIX="]" # remove space from the end
KUBE_PS1_NS_ENABLE=false # no ns
KUBE_PS1_SEPARATOR=: # used after the symbol, default |
KUBE_PS1_SYMBOL_PADDING=true # to draw correctly
KUBE_PS1_CTX_COLOR= # no color, red by default
KUBE_PS1_PREFIX='' # remove prefix
KUBE_PS1_SUFFIX=' ' # replace with space

# Stores the cancelled lines also in the history
# http://www.zsh.org/mla/users/2010/msg00241.html
TRAPINT () {
	zle && [[ $HISTNO -eq $HISTCMD ]] && print -s -r -- "$PREBUFFER$BUFFER"
	return $1
}

ssh-reagent () {
	if [ -n "$SSH_AGENT_PID" ]; then
		echo SSH Agent is running in this shell >&2
		return
	elif ssh-add -l > /dev/null 2>&1; then
		return
	fi
	# /auth-agent* is for devpod agent
	for agent in /tmp/ssh-*/agent.* /tmp/auth-agent*/listener.sock; do
		if [ -S "$agent" ]; then
			echo Found an SSH Agent: >&2
			export SSH_AUTH_SOCK="$agent"
			ssh-add -l >&2
			return
		fi
	done
	echo Cannot find SSH agent socket - maybe you should start it or reconnect and forward it? >&2
	unset SSH_AUTH_SOCK
}

# Personal preferences
export PATH="$HOME/bin:$PATH"
export EDITOR=vim

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
if command -v kubectl >/dev/null; then
	alias k=kubectl
	source <(kubectl completion zsh)
else
	kubeoff # kube-ps1
fi

if [ -f ~/.localzshrc ]; then
	source ~/.localzshrc
fi
if [ -f ~/.zshrc.local ]; then
	source ~/.zshrc.local
fi
