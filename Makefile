OMZ_SOURCE=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master

update: update-zsh-imports update-tmux-plugins

update-zsh-imports:
	# oh-my-zsh libs
	curl $(OMZ_SOURCE)/lib/directories.zsh > .zsh-partial-imports/lib/directories.zsh
	curl $(OMZ_SOURCE)/lib/history.zsh > .zsh-partial-imports/lib/history.zsh
	curl $(OMZ_SOURCE)/lib/key-bindings.zsh > .zsh-partial-imports/lib/key-bindings.zsh
	curl $(OMZ_SOURCE)/lib/completion.zsh > .zsh-partial-imports/lib/completion.zsh
	# oh-my-zsh plugins
	curl $(OMZ_SOURCE)/plugins/vi-mode/vi-mode.plugin.zsh > .zsh-partial-imports/vi-mode/vi-mode.plugin.zsh
	curl $(OMZ_SOURCE)/plugins/kube-ps1/kube-ps1.plugin.zsh > .zsh-partial-imports/kube-ps1/kube-ps1.plugin.zsh
	# faster git-prompt plugin
	curl https://raw.githubusercontent.com/woefe/git-prompt.zsh/master/git-prompt.zsh > .zsh-partial-imports/woefe-git-prompt/git-prompt.zsh

update-tmux-plugins:
	curl https://raw.githubusercontent.com/tmux-plugins/tmux-sensible/master/sensible.tmux > .tmux/partial-plugins/sensible.tmux
	curl https://raw.githubusercontent.com/jabirali/tmux-tilish/master/tilish.tmux > .tmux/partial-plugins/tilish.tmux
