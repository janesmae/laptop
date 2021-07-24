#!/usr/bin/env sh

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
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/laptop/master/symlinks.sh)"
eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/laptop/master/folders.sh)"

case "$(uname)" in
	Darwin)

		eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/laptop/master/macos-apps.sh)"
		eval "$(curl -fsSL https://raw.githubusercontent.com/janesmae/laptop/master/macos-settings.sh)"

	;;
esac

# Install ViM plugins
vim +PluginInstall +qall
