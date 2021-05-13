#! /bin/bash

## ----------------------------------------
##  master: https://github.com/ulwlu/dotfiles/blob/master/system/macos.sh
## ----------------------------------------

General() {
  # ========== Sidebar icon size ==========
  # - Small
  defaults write .GlobalPreferences NSTableViewDefaultSizeMode -int 1
  # - Medium
  # defaults write .GlobalPreferences NSTableViewDefaultSizeMode -int 2
  # - Large
  # defaults write .GlobalPreferences NSTableViewDefaultSizeMode -int 3
}

ScreenShot() {
  # ========== Set Screenshot saved directory ==========
  # - Default
  # defaults write com.apple.screencapture location -string "$HOME/Desktop"
  # - Custom
  defaults write com.apple.screencapture location -string "$HOME/Downloads"

  # ========== Set Screenshots format ==========
  # - png
  defaults write com.apple.screencapture type -string "png"
  # - jpg
  # defaults write com.apple.screencapture type -string "jpg"
  # - bmp
  # defaults write com.apple.screencapture type -string "bmp"

  # ========== Disable shadow of screenshot ==========
  # - Disable
  defaults write com.apple.screencapture disable-shadow -bool true
  # - Default
  # defaults write com.apple.screencapture disable-shadow -bool false

  # ========== Rename screenshot default name ==========
  # - Default
  # defaults delete com.apple.screencapture name
  # - Custom
  defaults write com.apple.screencapture name -string "ss"

  # ========== Remove timestamp ==========
  # - Remove
  # defaults write com.apple.screencapture include-date -bool false
  # - Default
  defaults write com.apple.screencapture include-date -bool true
}

Finder() {
  # ========== Show these items on the desktop ==========
  # - Hard disks
  #  - Checked
  # defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  #  - Unchecked
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

  # - External disks
  #  - Checked
  # defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  #  - Unchecked
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false

  # - CDs, DVDs, and iPods
  #  - Checked
  # defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  #  - Unchecked
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

  # - Connected servers
  #  - Checked
  # defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  #  - Unchecked
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

  # ========== New Finder windows show ==========
  defaults write com.apple.finder NewWindowTarget -string "${HOME}"

  # ========== Open folders in tabs instead of new windows ==========
  # - Checked
  defaults write com.apple.finder FinderSpawnTab -bool true
  # - Unchecked
  # defaults write com.apple.finder FinderSpawnTab -bool false

  # ========== Recent Tags ==========
  # - Checked
  # defaults write com.apple.finder ShowRecentTags -bool true
  # - Unchecked
  defaults write com.apple.finder ShowRecentTags -bool false

  # ========== Show all filename extensions ==========
  # - Checked
  defaults write -g AppleShowAllExtensions -bool true
  # - Unchecked
  # defaults write -g AppleShowAllExtensions -bool false

  # ========== Show warning before changing an extension ==========
  # - Checked
  # defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
  # - Unchecked
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # ========== Show warning before removing from iCloud Drive ==========
  # - Checked
  # defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool true
  # - Unchecked
  defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

  # ========== Show warning before emptying the Trash ==========
  # - Checked
  # defaults write com.apple.finder WarnOnEmptyTrash -bool true
  # - Unchecked
  defaults write com.apple.finder WarnOnEmptyTrash -bool false

  # ========== Remove items from the Trash after 30 days ==========
  # - Checked
  defaults write com.apple.finder FXRemoveOldTrashItems -bool true
  # - Unchecked
  # defaults write com.apple.finder FXRemoveOldTrashItems -bool false

  # ========== View ==========
  # - as Icons
  # defaults write com.apple.Finder FXPreferredViewStyle -string icnv
  # - as Columns
  defaults write com.apple.Finder FXPreferredViewStyle -string Nlsv
  # - as Gallary View
  # defaults write com.apple.Finder FXPreferredViewStyle -string clmv
  # - as List
  # defaults write com.apple.Finder FXPreferredViewStyle -string Flwv

  # ========== Icon Size ==========
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 36" "${HOME}"/Library/Preferences/com.apple.finder.plist

  # ========== Text Size ==========
  /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 12" "${HOME}"/Library/Preferences/com.apple.finder.plist

  # ========== Show Toolbar ==========
  # - Checked
  defaults write com.apple.finder ShowSidebar -bool true
  defaults write com.apple.finder ShowPreviewPane -bool true
  # - Unchecked
  # defaults write com.apple.finder ShowSidebar -bool false
  # defaults write com.apple.finder ShowPreviewPane -bool false

  # ========== Show Path Bar ==========
  # - Checked
  defaults write com.apple.finder ShowPathbar -bool true
  # - Unchecked
  # defaults write com.apple.finder ShowPathbar -bool false

  # ========== Show Tab Bar ==========
  # - Checked
  defaults write com.apple.finder ShowTabView -bool true
  # - Unchecked
  # defaults write com.apple.finder ShowTabView -bool false

  # ========== Show Status Bar ==========
  # - Checked
  defaults write com.apple.finder ShowStatusBar -bool true
  # - Unchecked
  # defaults write com.apple.finder ShowStatusBar -bool false

  # ========== Show Hidden Files ==========
  defaults write com.apple.finder AppleShowAllFiles true

  # ========== Show Directory Details ==========
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  # ========== Search current directory when exec search in Finder ==========
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # ========== Disable Animation in Finder ==========
  defaults write com.apple.finder DisableAllAnimations -bool true
}

Keyboard() {
  # ========== Key Repeat ==========
  # @int: 15 is the fastest in GUI, but real is 10
  defaults write .GlobalPreferences InitialKeyRepeat -int 15

  # ========== Delay Until Repeat ==========
  # @int: 2 is the fastest in GUI, but real is 1
  defaults write .GlobalPreferences KeyRepeat -int 2
}

ExtraSettings() {
  # ========== Dock Applications ==========
  # defaults delete com.apple.dock persistent-apps

  # ========== Disable DS_STORE in Network and USB ==========
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # ========== Crash Reporter to be in Notification but Popup Window ==========
  defaults write com.apple.CrashReporter UseUNC 1

  # ========== Disable Sound on Boot ==========
  sudo nvram SystemAudioVolume=" "
}

## ----------------------------------------
##  Run
## ----------------------------------------
General
ScreenShot
Finder
Keyboard
ExtraSettings

killall Dock
killall Finder
killall SystemUIServer
