#!/usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ./scripts/index.sh

info "Setting macOS defaults..."

# Closes System Preferences to prevent it from overriding settings we're about to change
osascript -e 'tell application "System Preferences" to quit'

sudo -v

## General UI/UX

# Increase window resize speed for native applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable the quaranine warning when opening downloaded apps
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Close window when quitting an app
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Add system information to the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable automatic correction
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Increase sound quality for Bluetooth headsets (ATH-M50xBT2 ftw)
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Allow holding keys to repeat characters
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

## Screen

# Ask for password immediately after sleep or screen saver starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 1

## Finder

# Show icons for hard drives, servers and removable media on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Don't create .DS_Store files on network volumes or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable the warning when emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the /Volumes folder
sudo chflags nohidden /Volumes

## Dock

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.15

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

success "Finished setting macOS defaults. Some changes require a restart to take effect."
