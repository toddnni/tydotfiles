OMZ_SOURCE=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master

update: update-zsh-imports update-tmux-plugins

update-zsh-imports:
	# oh-my-zsh libs
	curl -f $(OMZ_SOURCE)/lib/directories.zsh > .zsh-partial-imports/lib/directories.zsh
	curl -f $(OMZ_SOURCE)/lib/history.zsh > .zsh-partial-imports/lib/history.zsh
	curl -f $(OMZ_SOURCE)/lib/key-bindings.zsh > .zsh-partial-imports/lib/key-bindings.zsh
	curl -f $(OMZ_SOURCE)/lib/completion.zsh > .zsh-partial-imports/lib/completion.zsh
	curl -f $(OMZ_SOURCE)/LICENSE.txt > .zsh-partial-imports/lib/LICENSE.txt
	# oh-my-zsh plugins
	curl -f $(OMZ_SOURCE)/plugins/vi-mode/vi-mode.plugin.zsh > .zsh-partial-imports/vi-mode/vi-mode.plugin.zsh
	cp -a .zsh-partial-imports/lib/LICENSE.txt .zsh-partial-imports/vi-mode/LICENSE.txt
	curl -f $(OMZ_SOURCE)/plugins/kube-ps1/kube-ps1.plugin.zsh > .zsh-partial-imports/kube-ps1/kube-ps1.plugin.zsh
	cp -a .zsh-partial-imports/lib/LICENSE.txt .zsh-partial-imports/kube-ps1/LICENSE.txt
	# faster git-prompt plugin
	curl -f https://raw.githubusercontent.com/woefe/git-prompt.zsh/master/git-prompt.zsh > .zsh-partial-imports/woefe-git-prompt/git-prompt.zsh
	curl -f https://raw.githubusercontent.com/woefe/git-prompt.zsh/master/LICENSE > .zsh-partial-imports/woefe-git-prompt/LICENSE
	@echo "## Commit info below"
	curl -fs https://api.github.com/repos/ohmyzsh/ohmyzsh/commits/master | python3 -c 'import json,sys; j=json.load(sys.stdin); print("\n".join([j["sha"],j["commit"]["author"]["name"],j["commit"]["author"]["date"],"",j["commit"]["message"]]))'

update-tmux-plugins:
	curl -f https://raw.githubusercontent.com/tmux-plugins/tmux-sensible/master/sensible.tmux > .tmux/partial-plugins/sensible.tmux
	curl -f https://raw.githubusercontent.com/tmux-plugins/tmux-sensible/master/LICENSE.md > .tmux/partial-plugins/LICENSE-sensible.md
	@echo "## Commit info below"
	curl -fs https://api.github.com/repos/tmux-plugins/tmux-sensible/commits/master | python3 -c 'import json,sys; j=json.load(sys.stdin); print("\n".join([j["sha"],j["commit"]["author"]["name"],j["commit"]["author"]["date"],"",j["commit"]["message"]]))'

	curl -f https://raw.githubusercontent.com/jabirali/tmux-tilish/master/tilish.tmux > .tmux/partial-plugins/tilish.tmux
	curl -f https://raw.githubusercontent.com/jabirali/tmux-tilish/master/LICENSE > .tmux/partial-plugins/LICENSE-tilish
	@echo "## Commit info below"
	curl -fs https://api.github.com/repos/jabirali/tmux-tilish/commits/master | python3 -c 'import json,sys; j=json.load(sys.stdin); print("\n".join([j["sha"],j["commit"]["author"]["name"],j["commit"]["author"]["date"],"",j["commit"]["message"]]))'
