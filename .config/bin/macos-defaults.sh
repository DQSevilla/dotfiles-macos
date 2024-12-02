#!/usr/bin/env bash

# Script to set-up preferred MacOS settings.
# Initially inspired by https://github.com/guptarohit/dotfiles/blob/main/macos/defaults.sh

# === Finder ===

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# === Dock ===

# Don't show recently used applications in the Dock
defaults write com.Apple.Dock show-recents -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# === Force Restart ===
echo "Restarting Applications..."
killall Dock
killall Finder
