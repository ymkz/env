#! /bin/bash

## ----------------------------------------
##  master: https://github.com/ulwlu/dotfiles/blob/master/system/macos.sh
## ----------------------------------------

General() {
  # ========== Apprerance ==========
  # - Light
  # defaults delete .GlobalPreferences AppleInterfaceStyleSwitchesAutomatically > /dev/null 2>&1
  # defaults delete .GlobalPreferences AppleInterfaceStyle > /dev/null 2>&1
  # - Dark
  # defaults delete .GlobalPreferences AppleInterfaceStyleSwitchesAutomatically > /dev/null 2>&1
  # defaults write .GlobalPreferences AppleInterfaceStyle -string "Dark"
  # - Auto
  # defaults write .GlobalPreferences AppleInterfaceStyleSwitchesAutomatically -bool true

  # ========== Accent color ==========
  # - Blue
  # defaults delete .GlobalPreferences AppleAccentColor > /dev/null 2>&1
  # - Purple
  # defaults write .GlobalPreferences AppleAccentColor -int 5
  # - Pink
  # defaults write .GlobalPreferences AppleAccentColor -int 6
  # - Red
  # defaults write .GlobalPreferences AppleAccentColor -int 0
  # - Orange
  # defaults write .GlobalPreferences AppleAccentColor -int 1
  # - Yellow
  # defaults write .GlobalPreferences AppleAccentColor -int 2
  # - Green
  # defaults write .GlobalPreferences AppleAccentColor -int 3
  # - Grphite
  # defaults write .GlobalPreferences AppleAccentColor -string "-1"

  # ========== Highlight color ==========
  # - Blue
  # defaults delete .GlobalPreferences AppleHighlightColor > /dev/null 2>&1
  # - Purple
  # defaults write .GlobalPreferences AppleHighlightColor -string "0.968627 0.831373 1.000000 Purple"
  # - Pink
  # defaults write .GlobalPreferences AppleHighlightColor -string "1.000000 0.749020 0.823529 Pink"
  # - Red
  # defaults write .GlobalPreferences AppleHighlightColor -string "1.000000 0.733333 0.721569 Red"
  # - Orange
  # defaults write .GlobalPreferences AppleHighlightColor -string "1.000000 0.874510 0.701961 Orange"
  # - Yellow
  # defaults write .GlobalPreferences AppleHighlightColor -string "1.000000 0.937255 0.690196 Yellow"
  # - Green
  # defaults write .GlobalPreferences AppleHighlightColor -string "0.752941 0.964706 0.678431 Green"
  # - Grphite
  # defaults write .GlobalPreferences AppleHighlightColor -string "0.847059 0.847059 0.862745 Graphite"
  # - Other
  # defaults write .GlobalPreferences AppleHighlightColor -string "Your NSColor"

  # ========== Sidebar icon size ==========
  # - Small
  defaults write .GlobalPreferences NSTableViewDefaultSizeMode -int 1
  # - Medium
  # defaults write .GlobalPreferences NSTableViewDefaultSizeMode -int 2
  # - Large
  # defaults write .GlobalPreferences NSTableViewDefaultSizeMode -int 3

  # ========== Automatically hide and show the menu bar ==========
  # - Checked
  defaults write .GlobalPreferences _HIHideMenuBar -bool true
  # - Unchecked
  # defaults write .GlobalPreferences _HIHideMenuBar -bool false

  # ========== Show scroll bars ==========
  # - Automatically based on mouse or trackpad
  defaults write .GlobalPreferences AppleShowScrollBars -string "Automatic"
  # - When scrolling
  # defaults write .GlobalPreferences AppleShowScrollBars -string "WhenScrolling"
  # - Always
  # defaults write .GlobalPreferences AppleShowScrollBars -string "Always"

  # ========== Click in the scroll bar to ==========
  # - Jump to the next page
  # defaults write .GlobalPreferences AppleScrollerPagingBehavior -bool false
  # - Jump to the spot that's clicked
  defaults write .GlobalPreferences AppleScrollerPagingBehavior -bool true

  # ========== Ask to keep changes when closing documents ==========
  # - Checked
  # defaults write .GlobalPreferences NSCloseAlwaysConfirmsChanges -bool true
  # - Unchecked
  defaults write .GlobalPreferences NSCloseAlwaysConfirmsChanges -bool false

  # ========== Close windows when quitting an app ==========
  # - Checked
  # defaults write .GlobalPreferences NSQuitAlwaysKeepsWindows -bool false
  # - Unchecked
  defaults write .GlobalPreferences NSQuitAlwaysKeepsWindows -bool true

  # ========== Recent items ==========
  # - None
  # - 5
  # - 10
  # - 15
  # @string: choose preferred item.
  # osascript -e "
  #   tell application \"System Preferences\"
  #     activate
  #     set current pane to pane \"com.apple.preference.general\"
  #   end tell
  #   tell application \"System Events\"
  #     tell application process \"System Preferences\"
  #       repeat while not (window 1 exists)
  #       end repeat
  #       tell window 1
  #         tell pop up button 4
  #           delay 1
  #           click
  #           tell menu 1
  #             click menu item \"None\"
  #           end tell
  #         end tell
  #       end tell
  #     end tell
  #   end tell
  # "

  # ========== Allow Handoff between this Mac and your iCloud devices ==========
  # - Checked
  # defaults -currentHost write com.apple.coreservices.useractivityd.plist ActivityReceivingAllowed -bool true
  # defaults -currentHost write com.apple.coreservices.useractivityd.plist ActivityAdvertisingAllowed -bool true
  # - Unchecked
  defaults -currentHost write com.apple.coreservices.useractivityd.plist ActivityReceivingAllowed -bool false
  defaults -currentHost write com.apple.coreservices.useractivityd.plist ActivityAdvertisingAllowed -bool false

  # ========== Use font smoothing when available ==========
  # - Checked
  defaults -currentHost delete .GlobalPreferences AppleFontSmoothing
  # - Unchecked
  # defaults -currentHost write .GlobalPreferences AppleFontSmoothing -bool false
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
  defaults write com.apple.screencapture include-date -bool false
  # - Default
  # defaults write com.apple.screencapture include-date -bool true
}

Dock() {
  # ========== Size ==========
  # @int: size
  defaults write com.apple.dock tilesize -int 40

  # ========== Magnification ==========
  # - Checked
  # defaults write com.apple.dock magnification -bool true
  # - Unchecked
  defaults delete com.apple.dock magnification

  # ========== `Magnification` Bar ==========
  # @int: size
  # defaults write com.apple.dock largesize -int 128

  # ========== Position on screen ==========
  # - Left
  # defaults write com.apple.dock orientation -string "left"
  # - Bottom
  # defaults delete com.apple.dock orientation
  # - Right
  # defaults write com.apple.dock orientation -string "right"

  # ========== Minimize windows using ==========
  # - Genie effect
  # defaults write com.apple.dock mineffect -string "genie"
  # - Scale effect
  defaults write com.apple.dock mineffect -string "scale"

  # ========== Prefer tabs when opening documents ==========
  # - Always
  defaults write .GlobalPreferences AppleWindowTabbingMode -string "always"
  # - In Full Screen Only
  # defaults write .GlobalPreferences AppleWindowTabbingMode -string "fullscreen"
  # - Manually
  # defaults write .GlobalPreferences AppleWindowTabbingMode -string "manual"

  # ========== Double-click a window's title bar to ==========
  # - Checked
  # `Double-click a window's title bar to` pop up menu
  #  - minimize
  defaults write .GlobalPreferences AppleActionOnDoubleClick -string "Minimize"
  #  - zoom
  # defaults write .GlobalPreferences AppleActionOnDoubleClick -string "Maximize"
  # - Unchecked
  # defaults write .GlobalPreferences AppleActionOnDoubleClick -string "None"

  # ========== Minimize windows into application icon ==========
  # - Checked
  defaults write com.apple.dock minimize-to-application -bool true
  # - Unchecked
  # defaults write com.apple.dock minimize-to-application -bool false

  # ========== Animate opening applications ==========
  # - Checked
  # defaults write com.apple.dock launchanim -bool true
  # - Unchecked
  defaults write com.apple.dock launchanim -bool false

  # ========== Automatically hide and show the Dock ==========
  # - Checked
  defaults write com.apple.dock autohide -bool true
  # - Unchecked
  # defaults delete com.apple.dock autohide

  # ========== Show indicators for open applications ==========
  # - Checked
  defaults write com.apple.dock show-process-indicators -bool true
  # - Unchecked
  # defaults write com.apple.dock show-process-indicators -bool false

  # ========== Show recent applications in Dock ==========
  # - Checked
  # defaults write com.apple.dock show-recents -bool true
  # - Unchecked
  defaults write com.apple.dock show-recents -bool false

  # ========== Expose animation duration ==========
  defaults write com.apple.dock expose-animation-duration -float 0
}

CrashReporter() {
  defaults write com.apple.CrashReporter DialogType -string "none"
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
  defaults write com.apple.finder NewWindowTarget -string "${HOME}/work"

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
}

Keyboard() {
  # ========== Key Repeat ==========
  # @int: 15 is the fastest in GUI, but real is 10
  defaults write .GlobalPreferences InitialKeyRepeat -int 10

  # ========== Delay Until Repeat ==========
  # @int: 2 is the fastest in GUI, but real is 1
  defaults write .GlobalPreferences KeyRepeat -int 1
}

Trackpad() {
  defaults write NSGlobalDomain com.apple.mouse.scaling -1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.trackpad.forceClick -int 0
  defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
  defaults write com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad -bool true
}

EnergySaver() {
  # ========== Show Battery status in menu bar ==========
  # - Checked
  # IS_BATTERY=$(defaults read com.apple.systemuiserver menuExtras | grep "Battery")
  # [[ -z ${IS_BATTERY} ]] && /usr/libexec/PlistBuddy -c "Add menuExtras \"/System/Library/CoreServices/Menu Extras/Battery.menu\"" "${HOME}"/Library/Preferences/com.apple.systemuiserver.plist
  # - Unchecked
  # IS_BATTERY=$(defaults read com.apple.systemuiserver menuExtras | grep "Battery")
  # [[ -n ${IS_BATTERY} ]] && /usr/libexec/PlistBuddy -c "Delete menuExtras:\"/System/Library/CoreServices/Menu Extras/Battery.menu\"" "${HOME}"/Library/Preferences/com.apple.systemuiserver.plist

  # ========== Show Battery percentage in menu bar ==========
  # - Show
  # defaults write com.apple.menuextra.battery ShowPercent -string "Yes"
  # - Hide
  defaults write com.apple.menuextra.battery ShowPercent -string "NO"

  # ========== Turn display off after ==========
  # @int: minutes
  sudo pmset -b displaysleep 30

  # ========== Put hard disks to sleep when possible ==========
  # - Checked
  sudo pmset -b disksleep 1
  # - Unchecked
  # sudo pmset -b disksleep 0

  # ========== Slightly dim the display while on battery power ==========
  # - Checked
  # sudo pmset -b lessbright 0
  # - Unchecked
  sudo pmset -b lessbright 0

  # ========== Enable Power Nap while on battery power ==========
  # - Checked
  # sudo pmset -b powernap 1
  # - Unchecked
  sudo pmset -b powernap 0

  # ========== Prevent computer from sleeping automatically when the display is off ==========
  sudo pmset -c sleep 0

  # ========== Wake for Wi-Fi network access ==========
  # - Checked
  sudo pmset -c womp 1
  # - Unchecked
  # sudo pmset -c womp 0
}

DateTime() {
  # ========== Set date and time automatically ==========
  # - Checked
  sudo systemsetup -setusingnetworktime on > /dev/null
  # - Unchecked
  # sudo systemsetup -setusingnetworktime off > /dev/null

  # ========== Show date and time in menu bar ==========
  # - Checked
  # IS_CLOCK=$(defaults read com.apple.systemuiserver menuExtras | grep "Clock")
  # [[ -z ${IS_CLOCK} ]] && /usr/libexec/PlistBuddy -c "Add menuExtras \"/System/Library/CoreServices/Menu Extras/Clock.menu\"" "${HOME}"/Library/Preferences/com.apple.systemuiserver.plist
  # - Unchecked
  # IS_CLOCK=$(defaults read com.apple.systemuiserver menuExtras | grep "Clock")
  # [[ -n ${IS_CLOCK} ]] && /usr/libexec/PlistBuddy -c "Delete menuExtras:\"/System/Library/CoreServices/Menu Extras/Clock.menu\"" "${HOME}"/Library/Preferences/com.apple.systemuiserver.plist

  # ========== Time options ==========
  # - Digital
  defaults write com.apple.menuextra.clock IsAnalog -bool false
  # - Analog
  # defaults write com.apple.menuextra.clock IsAnalog -bool true

  # ========== Display the time with seconds ==========
  # - Checked
  # defaults write com.apple.menuextra.clock DateFormat -string "HH:mm:ss"
  # - Unchecked
  defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"

  # ========== Flash the time separators ==========
  # - Checked
  # defaults write com.apple.menuextra.clock FlashDateSeparators -bool true
  # - Unchecked
  defaults write com.apple.menuextra.clock FlashDateSeparators -bool false

  # ========== Use a 24-hour clock ==========
  # - Checked
  defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"
  # - Unchecked
  # defaults write com.apple.menuextra.clock DateFormat -string "H:mm"

  # ========== Show AM/PM ==========
  # - Checked
  # defaults write com.apple.menuextra.clock DateFormat -string "H:mm"
  # - Unchecked
  defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"

  # ========== Show the day of the week ==========
  # - Checked
  # defaults write com.apple.menuextra.clock DateFormat -string "EEE HH:mm"
  # - Unchecked
  defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"

  # ========== Show date ==========
  # - Checked
  # defaults write com.apple.menuextra.clock DateFormat -string "MMM d EEE HH:mm"
  # - Unchecked
  defaults write com.apple.menuextra.clock DateFormat -string "HH:mm"
}

ExtraSettings() {
  # ========== Dock Applications ==========
  defaults delete com.apple.dock persistent-apps

  # ========== Remove Notification ==========
  defaults write com.apple.LaunchServices LSQuarantine -bool false

  # ========== Disable DS_STORE in Network and USB ==========
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

  # ========== Show Hidden Files ==========
  defaults write com.apple.finder AppleShowAllFiles true

  # ========== Show Directory Details ==========
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

  # ========== Search current directory when exec search in Finder ==========
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # ========== Disable the warning when changing the extension ==========
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # ========== Disable System Preferences Red Bubble Notification ==========
  defaults write com.apple.systempreferences AttentionPrefBundleIDs 0

  # ========== Crash Reporter to be in Notification but Popup Window ==========
  defaults write com.apple.CrashReporter UseUNC 1

  # ========== Speed up Window Resize Animation ==========
  defaults write -g NSWindowResizeTime -float 0.001

  # ========== Disable Animation in Finder ==========
  defaults write com.apple.finder DisableAllAnimations -bool true

  # ========== Dock Start Appearance time ==========
  # - default
  # defaults delete com.apple.dock autohide-delay
  # @int/float: seconds
  defaults write com.apple.dock autohide-delay -float 1000

  # ========== Dock Appearance Animation time ==========
  # - default
  # defaults delete com.apple.dock autohide-time-modifier
  # @int/float: seconds
  defaults write com.apple.dock autohide-time-modifier -float 0

  # ========== Dock Icon Bouncing ==========
  # - default
  # defaults delete com.apple.dock no-bouncing
  # - No Bounce
  # defaults write com.apple.dock no-bouncing -bool TRUE

  # ========== Never allow password hints at login ==========
  sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0

  # ========== Disable Notification Center on menu ==========
  # launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

  # ========== Set Computer Name ==========
  # !!!!! This should not be set !!!!!
  # sudo scutil --set HostName "ymkz"
  # sudo scutil --set ComputerName "ymkz"
  # sudo scutil --set LocalHostName "ymkz"
  # sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "ymkz"

  # ========== Disable Sound on Boot ==========
  sudo nvram SystemAudioVolume=" "

  # ========== Never start sleep mode ==========
  # sudo systemsetup -setcomputersleep Off > /dev/null

  # ========== Start After ==========
  # @int: seconds
  defaults write com.apple.screensaver idleTime -int 0
}

## ----------------------------------------
##  Main
## ----------------------------------------
General
ScreenShot
Dock
CrashReporter
Finder
Keyboard
Trackpad
EnergySaver
DateTime
ExtraSettings

killall cfprefsd
killall Dock
killall Finder
killall SystemUIServer

## ----------------------------------------
##  Cache Clear
## ----------------------------------------
TESTMODE=$1
if ! ${TESTMODE}; then
  for app in \
    "cfprefsd" \
    "Activity Monitor" "Address Book" "Calendar" \
    "Contacts" "Dock" "Finder" "Mail" "Messages" \
    "SystemUIServer" "Terminal" "Transmission" "iCal"
  do
    killall "${app}"
  done
fi
