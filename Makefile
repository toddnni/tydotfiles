OMZ_SOURCE=https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master
update-zsh-imports:
	# oh-my-zsh libs
	curl $(OMZ_SOURCE)/lib/directories.zsh > .zsh-partial-imports/lib/directories.zsh
	curl $(OMZ_SOURCE)/lib/history.zsh > .zsh-partial-imports/lib/history.zsh
	curl $(OMZ_SOURCE)/lib/key-bindings.zsh > .zsh-partial-imports/lib/key-bindings.zsh
	curl $(OMZ_SOURCE)/lib/completion.zsh > .zsh-partial-imports/lib/completion.zsh
	# oh-my-zsh simple plugins
	curl $(OMZ_SOURCE)/plugins/vi-mode/vi-mode.plugin.zsh > .zsh-partial-imports/vi-mode/vi-mode.plugin.zsh
	curl $(OMZ_SOURCE)/plugins/git-prompt/git-prompt.plugin.zsh > .zsh-partial-imports/git-prompt/git-prompt.plugin.zsh
	curl $(OMZ_SOURCE)/plugins/git-prompt/gitstatus.py > .zsh-partial-imports/git-prompt/gitstatus.py
