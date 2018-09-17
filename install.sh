#!/usr/bin/env sh

# Abort on errors and unbound variables, set default file permissons
set -eu
umask 022

DOTFILES_VERSION='2.0.0'
DOTFILES_REPOSITORY="https://github.com/janesmae/dotfiles.git"
DOTFILES_FOLDER="$HOME/.files"

# Ask for sudo password and keep sudo alive until script finishes
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

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

# Create symlinks
ln -sfn ~/.files/zsh/zshrc ~/.zshrc
ln -sfn ~/.files/zsh/ ~/.zsh
ln -sfn ~/.files/vim/vimrc ~/.vimrc
ln -sfn ~/.files/vim/ ~/.vim
ln -sfn ~/.files/git/gitconfig ~/.gitconfig
ln -sfn ~/.files/git/gitignore ~/.gitignore
ln -sfn ~/.files/git/gitattributes ~/.gitattributes
ln -sfn ~/.files/git/gitmessage ~/.gitmessage
ln -sfn ~/.files/ansible/ansible.cfg ~/.ansible.cfg
ln -sfn ~/.files/ansible/ ~/.ansible
ln -sfn ~/.files/ssh/ ~/.ssh

# Create folders
mkdir -p ~/Development
mkdir -p ~/Screenshots

# Install ViM plugins
vim +PluginInstall +qall

case "$(uname)" in
	Darwin)
		if [ ! -f "$(command -v brew)" ]; then

# Install apps using Brew bundle
brew bundle install --file=- <<_BREW
$(curl -fsSL https://raw.githubusercontent.com/janesmae/dotfiles/install/Brewfile)
_BREW

# Rename the computer
sudo scutil --set ComputerName "Base"
sudo scutil --set HostName "Base"
sudo scutil --set LocalHostName "Base"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Base"

sudo pmset -a standbydelay 86400							# Set a long standby delay

defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false		# Disable menu bar transparency
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3				# Focus between all elements
defaults write NSGlobalDomain AppleShowAllExtensions -bool true				# Show all file extentions
defaults write NSGlobalDomain KeyRepeat -int 1						# Key repeat superfast
defaults write NSGlobalDomain InitialKeyRepeat -int 20					# Delay before the repeat
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark				# Menu bar to dark
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true			# Disable auto-termination of inactive apps

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true		# Turn on automatic update check
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1			# check for updates daily
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1			# Download updated in the background

defaults write com.apple.menuextra.battery ShowPercent -string "YES"			# Show remaining battery percentage

defaults write com.apple.dock autohide -bool true					# Hide dock
defaults write com.apple.dock orientation right						# Move dock on the right side
defaults write com.apple.dock static-only -bool true					# Show only running apps
defaults write com.apple.dock show-process-indicators -bool false			# Remove indicators
defaults write com.apple.dock tilesize -int 36						# Set new dock icon size

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true		# No .DS_Store on network shares
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true		# ... or USB drives

defaults write com.apple.screencapture location -string "${HOME}/Screenshots"		# Store screenshots in a special folder
defaults write com.apple.screencapture type -string "png"				# Store screenshots in png format

defaults write com.apple.screensaver askForPassword -int 1				# Ask for password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPasswordDelay -int 0

defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true		# Quit printer app when finished

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true			# Full path in finder window title
defaults write com.apple.finder ShowPathbar -bool true					# Show path bar in finder window
defaults write com.apple.finder ShowStatusBar -bool true				# Show status bar in finder window

defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true		# Show full url in Safari
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false			# Do not ipen safe files
defaults write com.apple.Safari IncludeDebugMenu -bool true				# Enable Safari debug menu

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true		# Disable Photos.app hotplug opening

defaults write com.googlecode.iterm2 PromptOnQuit -bool false				# Disable iTerm2 quit prompt

chflags nohidden ~/Library								# Unhide ~/Library

		fi
	;;
esac
