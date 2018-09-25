#!/usr/bin/env sh

# Ask for sudo password and keep sudo alive until script finishes
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Abort on errors and unbound variables, set default file permissons
set -eu
umask 022

DOTFILES_VERSION='2.0.0'
DOTFILES_REPOSITORY="https://github.com/janesmae/dotfiles.git"
DOTFILES_FOLDER="$HOME/.files"

case "$(uname)" in
	Darwin)
		if [ ! -f "$(command -v brew)" ]; then
			# Install Homebrew
			/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi
	;;
esac

# Look for git
_git=$(command -v git)

# Init dotfiles folder, fetch dotfiles and submodules
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

# Folders and symlinks
eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/dotfiles/install/symlinks.sh)"
eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/dotfiles/install/folders.sh)"

# Install ViM plugins
vim +PluginInstall +qall

case "$(uname)" in
	Darwin)

		eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/dotfiles/install/macos-apps.sh)"
		eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/dotfiles/install/macos-settings.sh)"

	;;
esac
