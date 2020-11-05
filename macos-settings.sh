#!/usr/bin/env sh

case "$(uname)" in
	Darwin)

# Ask for computer name
echo Please enter the desired hostname [j4nesh]:
read -r HOSTVAR

# Rename the computer
sudo scutil --set ComputerName "${HOSTVAR:-j4nesh}"
sudo scutil --set HostName "${HOSTVAR:-j4nesh}"
sudo scutil --set LocalHostName "${HOSTVAR:-j4nesh}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${HOSTVAR:-j4nesh}"

# Add message to lock screen
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If found, contact me:\nlost@janesmae.com"

sudo pmset -a standbydelay 86400							# Set a long standby delay

defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false		# Disable menu bar transparency
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3				# Focus between all elements
defaults write NSGlobalDomain AppleShowAllExtensions -bool true				# Show all file extentions
defaults write NSGlobalDomain KeyRepeat -int 1						# Key repeat superfast
defaults write NSGlobalDomain InitialKeyRepeat -int 20					# Delay before the repeat
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark				# Menu bar to dark
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true			# Disable auto-termination of inactive apps
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true				# Add menu item for developer extras

defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true		# Turn on automatic update check
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1			# check for updates daily
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1			# Download updated in the background

defaults write com.apple.menuextra.battery ShowPercent -string "YES"			# Show remaining battery percentage

defaults write com.apple.dock autohide -bool true					# Hide dock
defaults write com.apple.dock orientation right						# Move dock on the right side
defaults write com.apple.dock static-only -bool true					# Show only running apps
defaults write com.apple.dock show-process-indicators -bool false			# Remove indicators
defaults write com.apple.dock show-recents -bool false					# Remove recent apps from dock
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
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false		# Don't show harddrives in desktop

defaults write com.apple.Safari AutoFillFromAddressBook -bool false			# Disable AutoFill address
defaults write com.apple.Safari AutoFillPasswords -bool false				# Disable AutoFill passwords
defaults write com.apple.Safari AutoFillCreditCardData -bool false			# Disable AutoFill CC data
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false			# Disable other AutoFill items
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true		# Show full url in Safari
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false			# Do not ipen safe files
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true			# Enable Safari debug menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true				# Include developer menu
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true	# Include developer extras
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true		# Disable Photos.app hotplug opening

defaults write com.googlecode.iterm2 PromptOnQuit -bool false				# Disable iTerm2 quit prompt

chflags nohidden ~/Library								# Unhide ~/Library

	;;
esac
