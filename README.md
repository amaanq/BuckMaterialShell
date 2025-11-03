# BuckMaterialShell (dykwabi)

## Do you know what a buck is?

> [!NOTE]
> This is a fork with nothing changed but the name, because I find the name `BuckMaterialShell` a bit cringy.

> [!WARNING]
> This only supports Nix, sorry.

<div align=center>

[![GitHub stars](https://img.shields.io/github/stars/AvengeMedia/BuckMaterialShell?style=for-the-badge&labelColor=101418&color=ffd700)](https://github.com/AvengeMedia/BuckMaterialShell/stargazers)
[![GitHub License](https://img.shields.io/github/license/AvengeMedia/BuckMaterialShell?style=for-the-badge&labelColor=101418&color=b9c8da)](https://github.com/AvengeMedia/BuckMaterialShell/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/v/release/AvengeMedia/BuckMaterialShell?style=for-the-badge&labelColor=101418&color=9ccbfb)](https://github.com/AvengeMedia/BuckMaterialShell/releases)
[![GitHub last commit](https://img.shields.io/github/last-commit/AvengeMedia/BuckMaterialShell?style=for-the-badge&labelColor=101418&color=9ccbfb)](https://github.com/AvengeMedia/BuckMaterialShell/commits/master)
[![AUR version](https://img.shields.io/aur/version/dykwabi-shell-bin?style=for-the-badge&labelColor=101418&color=9ccbfb)](https://aur.archlinux.org/packages/dykwabi-shell-bin)
[![AUR version (git)](https://img.shields.io/aur/version/dykwabi-shell-git?style=for-the-badge&labelColor=101418&color=9ccbfb&label=AUR%20(git))](https://aur.archlinux.org/packages/dykwabi-shell-git)
[![Ko-Fi donate](https://img.shields.io/badge/donate-kofi?style=for-the-badge&logo=ko-fi&logoColor=ffffff&label=ko-fi&labelColor=101418&color=f16061&link=https%3A%2F%2Fko-fi.com%2Favengemediallc)](https://ko-fi.com/avengemediallc)

</div>

A modern Wayland desktop shell built with [Quickshell](https://quickshell.org/) and [Go](https://go.dev/). Optimized for the [niri](https://github.com/YaLTeR/niri), [Hyprland](https://hyprland.org/), [sway](https://swaywm.org/), and [dwl/mangowc](https://github.com/DreamMaoMao/mangowc) compositors.

Features notifications, app launcher, wallpaper customization, and fully customizable with [plugins](https://github.com/AvengeMedia/dykwabi-plugin-registry).

## Screenshots

<div align="center">
<div style="max-width: 700px; margin: 0 auto;">

https://github.com/user-attachments/assets/1200a739-7770-4601-8b85-695ca527819a

</div>
</div>

<details><summary><strong>View More Screenshots</strong></summary>

<br>

<div align="center">

### Desktop Overview

<img src="https://github.com/user-attachments/assets/203a9678-c3b7-4720-bb97-853a511ac5c8" width="600" alt="BuckMaterialShell Desktop" />

### Dashboard

<img width="600" alt="BuckDash" src="https://github.com/user-attachments/assets/a937cf35-a43b-4558-8c39-5694ff5fcac4" />

### Application Launcher

<img src="https://github.com/user-attachments/assets/2da00ea1-8921-4473-a2a9-44a44535a822" width="450" alt="Spotlight Launcher" />

### Control Center

<img width="600" alt="Control Center" src="https://github.com/user-attachments/assets/732c30de-5f4a-4a2b-a995-c8ab656cecd5" />

### System Monitor

<img src="https://github.com/user-attachments/assets/b3c817ec-734d-4974-929f-2d11a1065349" width="600" alt="System Monitor" />

### Widget Customization

<img src="https://github.com/user-attachments/assets/903f7c60-146f-4fb3-a75d-a4823828f298" width="500" alt="Widget Customization" />

### Lock Screen

<img src="https://github.com/user-attachments/assets/3fa07de2-c1b0-4e57-8f25-3830ac6baf4f" width="600" alt="Lock Screen" />

### Dynamic Theming

<img src="https://github.com/user-attachments/assets/a81a68e3-4f7e-4246-8199-0fef1013d4cf" width="700" alt="Auto Theme" />

### Notification Center

<img src="https://github.com/user-attachments/assets/07cbde9a-0242-4989-9f97-5765c6458c85" width="350" alt="Notification Center" />

### Dock

<img src="https://github.com/user-attachments/assets/e6999daf-f7bf-4329-98fa-0ce4f0e7219c" width="400" alt="Dock" />

</div>

</details>

## Quick start (Arch, Fedora, Debian, Ubuntu, openSUSE)

```bash
curl -fsSL https://install.bucklinux.com | sh
```
*Installs dykwabi & dependencies*

*Or skip to [Installation](https://github.com/AvengeMedia/BuckMaterialShell?tab=readme-ov-file#installation)*

<details><summary><strong>Features</strong></summary>

**Core Widgets:**
- **TopBar**: fully customizable bar where widgets can be added, removed, and re-arranged.
  - **App Launcher** with fuzzy search, categories, and auto-sorting by most used apps.
  - **Workspace Switcher** Configurable workspace switcher.
  - **Focused Window** Displays the currently focused window app name and title.
  - **Running Apps** A view of all running apps, sorted by monitor, workspace, then position on workspace.
  - **Media Player** Short form media player with equalizer, song title, and controls.
  - **Clock** Clock and date widget
  - **Weather** Weather widget with customizable location
  - **System Tray** System tray applets with context menus.
  - **Process Monitor** CPU, RAM, and GPU usage percentages, temperatures. (requires [dgop](https://github.com/AvengeMedia/dgop))
  - **Power/Battery** Power/Battery widget for battery metrics and power profile changing.
  - **Notifications** Notification bell with a notification center popup
  - **Control Center** High-level view of network, bluetooth, and audio status
  - **Privacy Indicator** Attempts to reveal if a microphone or screen recording session is active, relying on Pipewire data sources
  - **Idle Inhibitor** Creates a systemd idle inhibitor to prevent sleep/locking from occuring.
- **Spotlight Launcher** A central search/launcher - apps, files, emojis, running apps, calculator, command running - and basically anything since it can be enriched with plugins.
- **Central Command** A combined music, weather, calendar, and events PopUp.
- **Process List** A process list, with system metrics and information. More detailed modal available via IPC.
- **Notification Center** A center for notifications that has support for grouping.
- **Dock** A dock with pinned apps support, recent apps support, and currently running application support.
- **Control Center** A full control center with user profile information, network, bluetooth, audio input/output, display controls, and night mode automation.
- **Lock Screen** Using quickshell's WlSessionLock with embedded virtual keyboard for Niri (Niri doesn't support placing virtual keyboard above lockscreen natively: [issue](https://github.com/YaLTeR/niri/issues/2201))
- **Notepad** A simple text notepad/scratchpad with auto-save to session data and file export/import functionality.

</details>

## Highlights

- Auto-theming GTK, QT, Terminal apps, and more with [matugen](https://github.com/InioX/matugen) + optional theme generation from wallpaper.
- 20+ widgets that can be added and re-arranged on the bar.
- Process list, temperature monitoring, and resource monitoring with [dgop](https://github.com/AvengeMedia/dgop)
- Notification service with support for grouping and richtext
- App launcher + Spotlighht launcher with fuzzy search
- Control center with mpris player, weather, and calendar integration.
- Clipboard history view with image previews.
- A dock for running apps + pinned apps
- Configure bluetooth, wifi, and audio input+output devices.
- A lock screen
- Idle monitoring - configure auto lock, screen off, suspend, and hibernate with different knobs for battery + AC power.
- A greeter
- A comprehensive plugin system for endless customization possibilities.

**TL;DR** *dykwabi replaces your waybar, swaylock, swayidle, hypridle, hyprlock, fuzzels, walker, mako, and basically everything you use to stitch a desktop together*

## Installation

### Compositor Setup

BuckMaterialShell particularly aims at supporting the **niri**, **Hyprland**, **sway**, and **dwl/MangoWC** compositors, but it does support more wayland compositors with a diminished feature set (no monitor off, workspace switcher, overview integration, etc.):

**Niri**:
```bash
# Arch Linux
sudo pacman -S niri

# Fedora  
sudo dnf copr enable yalter/niri && sudo dnf install niri
```

For detailed niri installation instructions, see the [niri Getting Started guide](https://yalter.github.io/niri/Getting-Started.html).

**Hyprland**:
```bash
# Arch Linux
sudo pacman -S hyprland

# Or from AUR for latest
paru -S hyprland-git

# Fedora
sudo dnf install hyprland

# Or use Copr for latest builds
sudo dnf copr enable solopasha/hyprland && sudo dnf install hyprland
```

For detailed Hyprland installation instructions, see the [Hyprland wiki](https://wiki.hypr.land/Getting-Started/Installation/).

**sway/dwl (MangoWC)**:

TODO - not documented.

### Buck Shell Installation

*feel free to contribute steps for other distributions*

#### Arch Linux - via AUR

```bash
# Stable release
paru -S dykwabi-shell-bin
# Latest -git
paru -S dykwabi-shell-git
```

#### Fedora - via COPR

```bash
# Stable release
sudo dnf copr enable avengemedia/dykwabi && sudo dnf install dykwabi
# Latest -git
sudo dnf copr enable avengemedia/dykwabi-git && sudo dnf install dykwabi
```

#### NixOS - via flake

```bash
nix profile install github:AvengeMedia/BuckMaterialShell
```

#### NixOS - via home-manager

To install using home-manager, you need to add this repo into your flake inputs:

``` nix
dgop = {
  url = "github:AvengeMedia/dgop";
  inputs.nixpkgs.follows = "nixpkgs";
};
dykwabi-cli = {
  url = "github:amaanq/dykwabi";
  inputs.nixpkgs.follows = "nixpkgs";
};
buckMaterialShell = {
  url = "github:AvengeMedia/BuckMaterialShell";
  inputs.nixpkgs.follows = "nixpkgs";
  inputs.dgop.follows = "dgop";
  inputs.dykwabi-cli.follows = "dykwabi-cli";
};
```

Then somewhere in your home-manager config, add this to the imports:

``` nix
imports = [
  inputs.buckMaterialShell.homeModules.buckMaterialShell.default
];
```

If you use Niri, the `niri` homeModule provides additional options for Niri integration, such as key bindings and spawn:

``` nix
imports = [
  inputs.buckMaterialShell.homeModules.buckMaterialShell.default
  inputs.buckMaterialShell.homeModules.buckMaterialShell.niri
];
```

> [!IMPORTANT]
> To use the `niri` homeModule, you must have `sobidoo/niri-flake` in your inputs:

``` nix
niri = {
  url = "github:sodiboo/niri-flake";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

And import it in home-manager:

``` nix
imports = [
  inputs.niri.homeModules.niri
];
```

Now you can enable it with:

``` nix
programs.buckMaterialShell.enable = true;
```

There are a lot of possible configurations that you can enable/disable in the flake, check [nix/default.nix](nix/default.nix) and [nix/niri.nix](nix/niri.nix) to see them all.

#### Other Distributions - via manual installation

#### 1. Install Quickshell (Varies by Distribution)
```bash
# Arch
paru -S quickshell-git
# Fedora
sudo dnf copr enable avengemedia/bucklinux && sudo dnf install quickshell-git
# ! TODO - document other distros
```

#### 2. Install the shell

#### 2.1. Clone latest QML

```bash
mkdir ~/.config/quickshell && git clone https://github.com/AvengeMedia/BuckMaterialShell.git ~/.config/quickshell/dykwabi
```

**FOR Stable Version, Checkout the latest tag**

```bash
cd ~/.config/quickshell/dykwabi
# You'll have to re-run this, to update to the latest version.
git checkout $(git describe --tags --abbrev=0)
```

#### 2.2. Install latest dykwabi CLI

```bash
sudo sh -c "curl -L https://github.com/amaanq/dykwabi/releases/latest/download/dykwabi-$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/').gz | gunzip | tee /usr/local/bin/dykwabi > /dev/null && chmod +x /usr/local/bin/dykwabi"
```
**Note:** this is the latest *stable* dykwabi CLI. If you are using QML/master (not pinned to a tag), then you may  periodically be missing features, etc.

If preferred, you can build the dykwabi-cli yourself (requires GO 1.24+)

```bash
git clone https://github.com/amaanq/dykwabi.git && cd bucklinux
make && sudo make install
```

#### 3. Optional Features (system monitoring, clipboard history, brightness controls, etc.)

#### 3.1 Core optional dependencies
```bash
# Arch Linux
sudo pacman -S cava wl-clipboard cliphist brightnessctl qt6-multimedia accountsservice
paru -S matugen-bin dgop

# Fedora
sudo dnf install cava wl-clipboard brightnessctl qt6-qtmultimedia accountsservice
sudo dnf copr enable avengemedia/bucklinux && sudo dnf install cliphist ghostty hyprpicker matugen 
```
Note: by enabling and installing the avengemedia/dykwabi copr above, these core dependencies will automatically be available for use. 

*Other distros will just need to find sources for the above packages*

#### 3.2 - dgop manual installation

`dgop` is available via AUR and a nix flake, other distributions can install it manually.

```bash
sudo sh -c "curl -L https://github.com/AvengeMedia/dgop/releases/latest/download/dgop-linux-$(uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/').gz | gunzip | tee /usr/local/bin/dgop > /dev/null && chmod +x /usr/local/bin/dgop"
```

**Optional Requirement Overview**

- `dgop`: Ability to have system resource widgets, process list modal, and temperature monitoring.
- `matugen`: Wallpaper-based dynamic theming
- `brightnessctl`: Backlight and LED brightness control
- `wl-clipboard`: Required for copying various elements to clipboard.
- `cava`: Audio visualizer
- `cliphist`: Clipboard history
- `qt6-multimedia`: System sound support
- `accountsservice`: Ability to sync 

## Compositor Configuration

A lot of options are subject to personal preference, but the below sets a good starting point for most features.

### Systemd Autostart

**Alternative to compositor-specific autostart**: If you installed Dykwabi from the Fedora Copr repository, you can use systemd to manage Dykwabi autostart instead of adding `dykwabi run` to your compositor config.

**Benefits:**
- Works across all Wayland compositors (niri, Hyprland, sway, dwl, etc.)
- Centralized control via systemctl
- Automatic restart on failure
- Integrated logging via journalctl

**Enable autostart:**
```bash
systemctl --user enable dykwabi.service
```

**Manual control:**
```bash
# Start Dykwabi now
systemctl --user start dykwabi.service

# Check status
systemctl --user status dykwabi.service

# View logs
journalctl --user -u dykwabi.service -f

# Restart Dykwabi
systemctl --user restart dykwabi.service

# Disable autostart
systemctl --user disable dykwabi.service
```

**Note:** If using systemd autostart, remove `dykwabi run` / `spawn "dykwabi" "run"` from your compositor's configuration to avoid running Dykwabi twice.

### niri Integration

Add to your niri config

```kdl
// Required for clipboard history integration
spawn-at-startup "bash" "-c" "wl-paste --watch cliphist store &"

// Recommended (must install polkit-mate before hand) for elevation prompts
spawn-at-startup "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1"
// This may be a different path on different distributions, the above is for the arch linux mate-polkit package

// Starts BuckShell
spawn-at-startup "dykwabi" "run"

// If using niri newer than 271534e115e5915231c99df287bbfe396185924d (~aug 17 2025)
// you can add this to disable built in config load errors since buck shell provides this
config-notification {
    disable-failed
}

// Buck keybinds
// 1. These should not be in conflict with any pre-existing keybindings
// 2. You need to merge them with your existing config if you want to use these
// 3. You can change the keys to whatever you want, if you prefer something different
// 4. For the increment/decrement ones you can change the steps to whatever you like too
binds {
   Mod+Space hotkey-overlay-title="Application Launcher" {
      spawn "dykwabi" "ipc" "call" "spotlight" "toggle";
   }
   Mod+V hotkey-overlay-title="Clipboard Manager" {
      spawn "dykwabi" "ipc" "call" "clipboard" "toggle";
   }
   Mod+M hotkey-overlay-title="Task Manager" {
      spawn "dykwabi" "ipc" "call" "processlist" "toggle";
   }
   Mod+N hotkey-overlay-title="Notification Center" {
      spawn "dykwabi" "ipc" "call" "notifications" "toggle";
   }
   Mod+Comma hotkey-overlay-title="Settings" {
      spawn "dykwabi" "ipc" "call" "settings" "toggle";
   }
   Mod+P hotkey-overlay-title="Notepad" {
      spawn "dykwabi" "ipc" "call" "notepad" "toggle";
   }
   Super+Alt+L hotkey-overlay-title="Lock Screen" {
      spawn "dykwabi" "ipc" "call" "lock" "lock";
   }
   Mod+X hotkey-overlay-title="Power Menu" {
      spawn "dykwabi" "ipc" "call" "powermenu" "toggle";
   }
   Mod+C hotkey-overlay-title="Control Center" {
      spawn "dykwabi" "ipc" "call" "control-center" "toggle";
   }
   Mod+Y hotkey-overlay-title="Browse Wallpapers" {
      spawn "dykwabi" "ipc" "call" "buckdash" "wallpaper";
   }
   XF86AudioRaiseVolume allow-when-locked=true {
      spawn "dykwabi" "ipc" "call" "audio" "increment" "3";
   }
   XF86AudioLowerVolume allow-when-locked=true {
      spawn "dykwabi" "ipc" "call" "audio" "decrement" "3";
   }
   XF86AudioMute allow-when-locked=true {
      spawn "dykwabi" "ipc" "call" "audio" "mute";
   }
   XF86AudioMicMute allow-when-locked=true {
      spawn "dykwabi" "ipc" "call" "audio" "micmute";
   }
   XF86MonBrightnessUp allow-when-locked=true {
      spawn "dykwabi" "ipc" "call" "brightness" "increment" "5" "";
   }
   // You can override the default device for e.g. keyboards by adding the device name to the last param
   XF86MonBrightnessDown allow-when-locked=true {
      spawn "dykwabi" "ipc" "call" "brightness" "decrement" "5" "";
   }
   // Night mode toggle
   Mod+Shift+N allow-when-locked=true {
      spawn "dykwabi" "ipc" "call" "night" "toggle";
   }
}

// You probably want this too
debug {
   honor-xdg-activation-with-invalid-serial
}
```

#### niri - place wallpaper on overview (blurred or non-blurred)

Place the wallpaper on backdrop using a layer-rule for a contiguous surface.

```kdl
layer-rule {
    match namespace="quickshell"
    place-within-backdrop true
}
```

If using "Blur Layer" option, you may want the blurred layer to appear on overview only, that can be done with some layer rules:

```kdl
layer-rule {
    match namespace="dykwabi:blurwallpaper"
    place-within-backdrop true
}
```

#### niri theming

If using a niri build newer than [3933903](https://github.com/YaLTeR/niri/commit/39339032cee3453faa54c361a38db6d83756f750), you can synchronize colors and gaps with the shell settings by adding the following to your niri config.

```bash
# For colors
echo -e 'include "dykwabi/colors.kdl"' >> ~/.config/niri/config.kdl
# For gaps, border widths, certain window rules
echo -e 'include "dykwabi/layout.kdl"' >> ~/.config/niri/config.kdl
```

### Hyprland Integration

Add to your Hyprland config (`~/.config/hypr/hyprland.conf`):

```bash
# Required for clipboard history integration
exec-once = bash -c "wl-paste --watch cliphist store &"

# Recommended (must install polkit-mate beforehand) for elevation prompts  
exec-once = /usr/lib/mate-polkit/polkit-mate-authentication-agent-1
# This may be a different path on different distributions, the above is for the arch linux mate-polkit package

# Starts BuckShell
exec-once = dykwabi run

# Buck keybinds
# 1. These should not be in conflict with any pre-existing keybindings
# 2. You need to merge them with your existing config if you want to use these
# 3. You can change the keys to whatever you want, if you prefer something different
# 4. For the increment/decrement ones you can change the steps to whatever you like too

# Application and system controls
bind = SUPER, Space, exec, dykwabi ipc call spotlight toggle
bind = SUPER, V, exec, dykwabi ipc call clipboard toggle
bind = SUPER, M, exec, dykwabi ipc call processlist toggle
bind = SUPER, N, exec, dykwabi ipc call notifications toggle
bind = SUPER, comma, exec, dykwabi ipc call settings toggle
bind = SUPER, P, exec, dykwabi ipc call notepad toggle
bind = SUPERALT, L, exec, dykwabi ipc call lock lock
bind = SUPER, X, exec, dykwabi ipc call powermenu toggle
bind = SUPER, Y, exec, dykwabi ipc call buckdash wallpaper
bind = SUPER, C, exec, dykwabi ipc call control-center toggle
bind = SUPER, TAB, exec, dykwabi ipc call hypr toggleOverview

# Audio controls (function keys)
bindl = , XF86AudioRaiseVolume, exec, dykwabi ipc call audio increment 3
bindl = , XF86AudioLowerVolume, exec, dykwabi ipc call audio decrement 3
bindl = , XF86AudioMute, exec, dykwabi ipc call audio mute
bindl = , XF86AudioMicMute, exec, dykwabi ipc call audio micmute

# Brightness controls (function keys)
bindl = , XF86MonBrightnessUp, exec, dykwabi ipc call brightness increment 5 ""
# You can override the default device for e.g. keyboards by adding the device name to the last param
bindl = , XF86MonBrightnessDown, exec, dykwabi ipc call brightness decrement 5 ""

# Night mode toggle
bind = SUPERSHIFT, N, exec, dykwabi ipc call night toggle
```

## Greeter

You can install a matching [greetd](https://github.com/kennylevinsen/greetd) greeter, that will give you a greeter that matches the lock screen.

It's as simple as running `dykwabi greeter install` in most cases, but more information is in the [Greetd module](Modules/Greetd/README.md)

## IPC Commands

Control everything from the command line, or via keybinds. For comprehensive documentation of all available IPC commands, see [docs/IPC.md](docs/IPC.md).

### Audio control
```bash
dykwabi ipc call audio setvolume 50
dykwabi ipc call audio mute
```
### Launch applications
```bash
dykwabi ipc call spotlight toggle
dykwabi ipc call notepad toggle
dykwabi ipc call processlist toggle
dykwabi ipc call powermenu toggle
```
### System control
```
dykwabi ipc call wallpaper set /path/to/image.jpg
dykwabi ipc call theme toggle
dykwabi ipc call night toggle
dykwabi ipc call lock lock
```
### Media control
```
dykwabi ipc call mpris playPause
dykwabi ipc call mpris next
```

## Theming

dykwabi will spawn a matugen process on theme changes to generate color palettes for installed and supported apps. If you do not want these files generated, you can set the env variable `DYKWABI_DISABLE_MATUGEN=1` to disable it entirely.

### Custom Themes

BuckMaterialShell supports custom color themes! You can create your own Material Design 3 color schemes or use pre-made themes like Cyberpunk Electric, Hotline Miami, and Miami Vice.

For detailed instructions on creating and using custom themes, see [docs/CUSTOM_THEMES.md](docs/CUSTOM_THEMES.md).

### System App Integration

There's two toggles in the appearance section of settings, for GTK and QT apps.

These settings will override some local GTK and QT configuration files, you can still integrate auto-theming if you do not wish BuckShell to mess with your QTCT/GTK files.

No matter what when matugen is enabled the files will be created on wallpaper changes:

- ~/.config/gtk-3.0/buck-colors.css
- ~/.config/gtk-4.0/buck-colors.css
- ~/.config/qt6ct/colors/matugen.conf
- ~/.config/qt5ct/colors/matugen.conf

If you do not like our theme path, you can integrate this with other GTK themes, matugen themes, etc.

#### GTK Apps

1. Install adw-gtk3

```bash
# Arch
sudo pacman -S adw-gtk-theme
# Fedora
sudo dnf install adw-gtk3-theme
```

In dykwabi settings, navigate to Theme & Colors, and "apply GTK themes"

This will create symlinks from `~/.config/gtk-3.0/4.0/buck-colors.css` to `~/.config/gtk-3.0/4.0/gtk.css` which enables theming.

#### QT: basic gtk3 based theme (Option 1)

If you mostly use gtk apps, you'll probably be happy to just set the QT platform theme to gtk3.

```kdl
environment {
  // Add to existing environment block
  QT_QPA_PLATFORMTHEME "gtk3"
  QT_QPA_PLATFORMTHEME_QT6 "gtk3"
}
```

#### QT: better theming (Option 2)

1. Install qt6ct-kde

```bash
# Arch
paru -S qt6ct-kde
```

*I'm not sure what it is on other distros, but you can manually install via instructions provides on [qt6ct-kde github](https://www.opencode.net/trialuser/qt6ct)

2. **Configure Environment in niri**

```kdl
  // Add to existing environment block
  QT_QPA_PLATFORMTHEME "qt6ct"
  QT_QPA_PLATFORMTHEME_QT6 "qt6ct"
```

You'll have to restart your session for themes to take effect.

Nevigate to dykwabi settings -> themes & colors -> and click "Apply QT Themes"

#### Firefox

There are two theme paths for Firefox, using with [pywalfox](https://github.com/Frewacom/pywalfox) or [material fox](https://github.com/edelvarden/material-fox-updated)

**(Option 1) - pywalfox**

1. **Install [pywalfox](https://github.com/Frewacom/pywalfox)** on system.
- Available in AUR via `paru -S python-pywalfox`

2. **Install [pywalfox extension](https://addons.mozilla.org/firefox/addon/pywalfox/)** in firefox.

3. **Restart dykwabi and create symlink** to generate palette and then enable buck colors.
- Run `ln -sf ~/.cache/wal/buck-pywalfox.json ~/.cache/wal/colors.json`


**(Option 2) - Chrome-like theme with dynamic colors**

Firefox does use the GTK3 theme, but it doesn't look that good on the stock theme IMO. A separate matugen css is generated for the [material fox](https://github.com/edelvarden/material-fox-updated) theme, you can configure that theme with dynamic colors by following the steps below.

1. **In firefox, navigate to `about:config`**
- set `toolkit.legacyuserprofilecustomizations.stylesheets` to `true`
- set `svg.context-properties.content.enabled` to `true`
- Create a new property called `userChrome.theme-material` and type `boolean`
  - set to `true`

<details><summary><strong>Expand for firefox screenshots</strong></summary>
<img width="1262" height="104" alt="image" src="https://github.com/user-attachments/assets/4bca43d1-5735-4401-9b91-5ee4f0b1e357" />
<img width="1262" height="104" alt="image" src="https://github.com/user-attachments/assets/348d37e0-5c6c-4db8-b7c9-89cabf282c25" />
<img width="1244" height="106" alt="image" src="https://github.com/user-attachments/assets/75fd4972-bc4a-4657-b756-b31ef8061b3b" />
</details>

2. **Install material fox theme**
```bash
# Find Firefox profile directory
export PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default-release" | head -n 1)

# Download, extract to profile dir, and cleanup
curl -L -o "$PROFILE_DIR/chrome.zip" https://github.com/edelvarden/material-fox-updated/releases/download/v2.0.0/chrome.zip
unzip -o "$PROFILE_DIR/chrome.zip" -d "$PROFILE_DIR"
rm "$PROFILE_DIR/chrome.zip"
```

3. **Configure dynamic colors for material fox theme**
```bash
export PROFILE_DIR=$(find ~/.mozilla/firefox -maxdepth 1 -type d -name "*.default-release" | head -n 1)
rm -f "$PROFILE_DIR/chrome/theme-material-blue.css"
ln -sf ~/.config/BuckMaterialShell/firefox.css "$PROFILE_DIR/chrome/theme-material-blue.css"
```

### Terminal Integration

The matugen integration will automatically generate new colors for certain apps only if they are installed.

You can enable the dynamic color schemes in supported terminal apps by modifying their configurations:

**Ghostty**:

```bash
echo "config-file = ./config-buckcolors" >> ~/.config/ghostty/config
```

If you want to disable excessive config reloaded popup sin ghostty, you may wish to also add this:

```bash
# These are the default bucklinux options, if you still want config reloaded and copied to clipboard popups you can skip it.
echo "app-notifications = no-clipboard-copy,no-config-reload" >> ~/.config/ghostty/config
```

**kitty**:

```bash
echo "include buck-theme.conf" >> ~/.config/kitty/kitty.conf
```

## Plugins

[Plugin registry](https://github.com/AvengeMedia/dykwabi-plugin-registry) - collection of available dykwabi plugins.

dykwabi features a plugin system - meaning you can create your own widgets and load other user widgets.

More comprehensive details available in the [PLUGINS](PLUGINS/README.md) - and examples [Emoji Plugin](PLUGINS/ExampleEmojiPlugin) and [Wallpaper Change Hook](PLUGINS/WallpaperWatcherDaemon) are available for reference.

Install an example plugin by:

```bash
mkdir ~/.config/BuckMaterialShell/plugins
cp -R ./PLUGINS/ExampleEmojiPlugin ~/.config/BuckMaterialShell/plugins
```

**Only install plugins from TRUSTED sources.** Plugins execute QML and javascript at runtime, plugins from third parties should be reviewed before enabling them in dykwabi.

### NixOS - via home-manager

Add the following to your home-manager config to install a plugin:

```nix
programs.buckMaterialShell.plugins = {
    ExampleEmojiPlugin.src = "${inputs.buckMaterialShell}/PLUGINS/ExampleEmojiPlugin";
};
```

### Calendar Setup

Sync your caldev compatible calendar (Google, Office365, etc.) for dashboard integration:

<details><summary>Configuration Steps</summary>

**Install dependencies:**

#### Arch
```bash
sudo pacman -S vdirsyncer khal python-aiohttp-oauthlib
```

#### Fedora
```bash
sudo dnf install python3-vdirsyncer khal python3-aiohttp-oauthlib
```

**Configure vdirsyncer** (`~/.vdirsyncer/config`):

```ini
[general]
status_path = "~/.calendars/status"

[pair personal_sync]
a = "personal"
b = "personallocal"
collections = ["from a", "from b"]
conflict_resolution = "a wins"
metadata = ["color"]

[storage personal]
type = "google_calendar"
token_file = "~/.vdirsyncer/google_calendar_token"
client_id = "your_client_id"
client_secret = "your_client_secret"

[storage personallocal]
type = "filesystem"
path = "~/.calendars/Personal"
fileext = ".ics"
```

**Setup sync:**

```bash
vdirsyncer sync
khal configure
```

#### Auto-sync every 5 minutes
```bash
crontab -e
# Add: */5 * * * * /usr/bin/vdirsyncer sync
```

</details>

## Configuration

All settings are configurable in
```
~/.config/BuckMaterialShell/settings.json`, or more intuitively the built-in settings modal.
```

**Key configuration areas:**

- Widget positioning and behavior
- Theme and color preferences
- Time format, weather units and location
- Light/Dark modes
- Wallpaper and Profile picture
- Dock enable/disable and various tunes.

## Troubleshooting

**Common issues:**

- **No dynamic theming:** Install matugen and enable in settings
- **Qt apps not themed:** Configure qt5ct/qt6ct and set QT_QPA_PLATFORMTHEME
- **Calendar not syncing:** Check vdirsyncer credentials and network connectivity

**Getting help:**

- Check the [issues](https://github.com/AvengeMedia/BuckMaterialShell/issues) for known problems
- Re-run the shell with `dykwabi kill && dykwabi run` to capture logs.
- Join the niri community for compositor-specific questions

## Contributing

BuckMaterialShell welcomes contributions! Whether it's bug fixes, new widgets, theme improvements, or documentation updates - all help is appreciated.

**Areas that need attention:**

- More widget options and customization
- Additional compositor compatibility
- Performance optimizations
- Documentation and examples

## Credits

- [quickshell](https://quickshell.org/) the core of what makes a shell like this possible.
- [niri](https://github.com/YaLTeR/niri) for the awesome scrolling compositor.
- [Ly-sec](http://github.com/ly-sec) for awesome wallpaper effects among other things from [Noctalia](https://github.com/noctalia-dev/noctalia-shell)
- [soramanew](https://github.com/soramanew) who built [caelestia](https://github.com/caelestia-dots/shell) which served as inspiration and guidance for many buck widgets.
- [end-4](https://github.com/end-4) for [dots-hyprland](https://github.com/end-4/dots-hyprland) which also served as inspiration and guidance for many buck widgets.
