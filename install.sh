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
		rm -rf "$2"
		mkdir -p "$(dirname $2)"
		ln -s "$1" "$2"
		echo "LINKED"
	fi
}

cd "$(dirname $0)"
DIR="$PWD"
for file in .vimrc .zshrc
do
	if ! [ -f "$DIR/$file" ]
	then
		echo "File '$file' not found from git!"
		continue
	fi
	link "$DIR/$file" "$HOME/$file"
done
for dir in .vim/autoload .vim/doc .vim/plugin .zsh-partial-imports
do
	if ! [ -d "$DIR/$dir" ]
	then
		echo "Directory '$dir' not found from git!"
		continue
	fi
	link "$DIR/$dir" "$HOME/$dir"

done
