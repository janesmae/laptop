#!/usr/bin/env sh

set -eu
umask 022

DOTFILES_VERSION='2.0.0'
DOTFILES_REPOSITORY="https://github.com/janesmae/dotfiles.git"
DOTFILES_FOLDER="$HOME/.files"

case "$(uname)" in
	Darwin)
		if [ ! -f "$(command -v brew)" ]; then
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
			
		fi
	;;
esac

_git=$(command -v git)

if [ ! -d "$DOTFILES_FOLDER" ]; then
	parentdir=$(dirname "$DOTFILES_FOLDER")
	if [ ! -x "$parentdir" ]|[ ! -w "$parentdir" ]; then
		echo "ERROR: Location $DOTFILES_FOLDER is not writable" 1>&2
		exit 1
	else
		mkdir -p "$DOTFILES_FOLDER" && cd "$DOTFILES_FOLDER"
		$_git init -q
		$_git config core.autocrlf "false"
		$_git config remote.origin.url "$DOTFILES_REPOSITORY"
		$_git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
		$_git config remote.origin.pushurl no_push
		$_git fetch origin master:refs/remotes/origin/master --tags --force --quiet
		$_git reset --hard origin/master --quiet
		$_git submodule init --quiet
		$_git submodule update --quiet --recursive --remote
	fi
fi

ln -sfn ~/.files/zsh/zshrc ~/.zshrc
ln -sfn ~/.files/zsh/ ~/.zsh
ln -sfn ~/.files/vim/vimrc ~/.vimrc
ln -sfn ~/.files/vim/ ~/.vim
ln -sfn ~/.files/git/gitconfig ~/.gitconfig
ln -sfn ~/.files/git/gitignore ~/.gitignore
ln -sfn ~/.files/git/gitattributes ~/.gitattributes
ln -sfn ~/.files/git/gitmessage ~/.gitmessage
ln -sfn ~/.files/ansible/ansible.cfg ~/.ansible.cfg

mkdir -p ~/Development
mkdir -p ~/Screenshots

vim +PluginInstall +qall

sudo scutil --set ComputerName "Base"
sudo scutil --set HostName "Base"
sudo scutil --set LocalHostName "Base"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Base"

