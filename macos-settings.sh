#!/usr/bin/env sh

case "$(uname)" in
	Darwin)

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

	;;
esac
