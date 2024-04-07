# .zshrc

# oh-my-zsh integration, or not
if [ -f "$HOME/.oh-my-zsh.disable" ]; then
	unset ZSH
elif [ -d "$HOME/.oh-my-zsh" ]; then
	export ZSH="$HOME/.oh-my-zsh"
fi
if [ -n "$ZSH" ]; then
	ZSH_THEME=
	plugins=(vi-mode git-prompt)
	if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
		plugins+=zsh-syntax-highlighting
	fi
	zstyle ':omz:update' mode disabled
	source "$ZSH/oh-my-zsh.sh"
	P_MARK='%{$fg_bold[blue]%}∑%{$reset_color%}'
else
	# good enough ZSH without oh-my-zsh
	autoload -U colors && colors
	autoload -U compinit && compinit
	setopt COMPLETE_IN_WORD # on: completes inside a word
	setopt PROMPT_SUBST # on: substitute things in prompt all the time
	source ~/.zsh-partial-imports/lib/directories.zsh
	source ~/.zsh-partial-imports/lib/history.zsh
	source ~/.zsh-partial-imports/lib/key-bindings.zsh
	source ~/.zsh-partial-imports/vi-mode/vi-mode.plugin.zsh
	source ~/.zsh-partial-imports/git-prompt/git-prompt.plugin.zsh
	alias ls='ls --color'
	P_MARK='%{$fg_bold[blue]%}:%{$reset_color%}'
	if [ -d /usr/share/zsh-syntax-highlighting ]; then
		source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	fi
fi

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
# Or consider some base theme eg. oliver and add git_super_status
# PROMPT="${PROMPT} $(git_super_status)"
PROMPT='%{$fg_bold[blue]%}%D{%Y-%m-%d %H:%M}%{$reset_color%} %n'"$P_MARK"'%3~$(git_super_status)%(?..|%{$fg_bold[red]%}%?↵%{$reset_color%})%B%#%b '
# for plugins prompt integration
RPROMPT= # disable git-prompt right prompt
VI_MODE_SET_CURSOR=true
ZSH_THEME_GIT_PROMPT_CACHE=y

# Stores the cancelled lines also in the history
# http://www.zsh.org/mla/users/2010/msg00241.html
TRAPINT () {
	zle && [[ $HISTNO -eq $HISTCMD ]] && print -s -r -- "$PREBUFFER$BUFFER"
	return $1
}

# Personal preferences
export PATH="$HOME/bin:$PATH"
export EDITOR=vim

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

if [ -f ~/.localzshrc ]; then
	source ~/.localzshrc
fi
if [ -f ~/.zshrc.local ]; then
	source ~/.zshrc.local
fi
