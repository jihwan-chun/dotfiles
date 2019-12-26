#!/usr/bin/bash

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable 3-finger drag
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1

# Minimize keyboard input repeat delay and repeat period
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

# Tab touchpad to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Hot corner; Bottom left screen corner -> Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# For macOS with Korean input, use backquote(`) instead of Korean Won(₩)
if [ ! -f ~/Library/KeyBindings/DefaultkeyBinding.dict ]; then
	mkdir -p ~/Library/KeyBindings
  cat << EOF > ~/Library/KeyBindings/DefaultkeyBinding.dict
{
  "₩" = ("insertText:", "\`");
}
EOF
fi

# ------
# Finder
# ------
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles YES

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# ----
# Dock
# ----
# Automatically hide and show Dock
sudo defaults write /Library/Preferences/com.apple.dock autohide -bool YES
defaults write com.apple.dock autohide -bool true

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 64

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Arrange applications on Dock
dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/Launchpad.app"
dockutil --no-restart --add "/System/Applications/App Store.app"
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Notion.app"
dockutil --no-restart --add "/Applications/Pocket.app"
dockutil --no-restart --add "/Applications/Slack.app"
dockutil --no-restart --add "/Applications/KakaoTalk.app"
dockutil --no-restart --add "/Applications/Between.app"

# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done
