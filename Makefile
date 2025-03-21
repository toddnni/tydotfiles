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
	@echo "## Commit info below"
	curl -s https://api.github.com/repos/ohmyzsh/ohmyzsh/commits/master | python3 -c 'import json,sys; j=json.load(sys.stdin); print("\n".join([j["sha"],j["commit"]["author"]["name"],j["commit"]["author"]["date"],"",j["commit"]["message"]]))'

update-tmux-plugins:
	curl https://raw.githubusercontent.com/tmux-plugins/tmux-sensible/master/sensible.tmux > .tmux/partial-plugins/sensible.tmux
	@echo "## Commit info below"
	curl -s https://api.github.com/repos/tmux-plugins/tmux-sensible/commits/master | python3 -c 'import json,sys; j=json.load(sys.stdin); print("\n".join([j["sha"],j["commit"]["author"]["name"],j["commit"]["author"]["date"],"",j["commit"]["message"]]))'

	curl https://raw.githubusercontent.com/jabirali/tmux-tilish/master/tilish.tmux > .tmux/partial-plugins/tilish.tmux
	@echo "## Commit info below"
	curl -s https://api.github.com/repos/jabirali/tmux-tilish/commits/master | python3 -c 'import json,sys; j=json.load(sys.stdin); print("\n".join([j["sha"],j["commit"]["author"]["name"],j["commit"]["author"]["date"],"",j["commit"]["message"]]))'
