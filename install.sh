#!/bin/sh
echo "This file will link files in HOME to this repo"

link() {
	local link
	link=
	echo -n "$2: "
	if [ -L "$2" ] && [ $(readlink "$2") = "$1" ]
	then
		echo "OK"
	else
		mkdir -p "$(dirname $2)"
		if [ -L "$2" ]
		then
			rm "$2"
		elif [ -e "$2" ]
		then
			mv "$2" "$2".orig
		fi
		ln -s "$1" "$2"
		echo "LINKED"
	fi
}

cd "$(dirname $0)"
DIR="$PWD"
for file in .vimrc .zshrc .tmux.conf
do
	if ! [ -f "$DIR/$file" ]
	then
		echo "File '$file' not found from git!"
		continue
	fi
	link "$DIR/$file" "$HOME/$file"
done
for dir in .vim/autoload .vim/doc .vim/plugin .zsh-partial-imports .tmux/partial-plugins
do
	if ! [ -d "$DIR/$dir" ]
	then
		echo "Directory '$dir' not found from git!"
		continue
	fi
	link "$DIR/$dir" "$HOME/$dir"

done
