# Buck (dykwabi) Greeter

A greeter for [greetd](https://github.com/kennylevinsen/greetd) that follows the aesthetics of the dykwabi lock screen.

## Features

- **Multi user**: Login with any system user
- **dykwabi sync**: Sync settings with dykwabi for consistent styling between shell and greeter
- **niri or Hyprland**: Use either niri or Hyprland for the greeter's compositor.
- **Custom PAM**: Supports custom PAM configuration in `/etc/pam.d/buckshell`
- **Session Memory**: Remembers last selected session and user

## Installation

### Arch Linux

Arch linux users can install [greetd-dykwabi-greeter-git](https://aur.archlinux.org/packages/greetd-dykwabi-greeter-git) from the AUR.

```bash
paru -S greetd-dykwabi-greeter-git
# Or with yay
yay -S greetd-dykwabi-greeter-git
```

Once installed, disable any existing display manager and enable greetd:

```bash
sudo systemctl disable gdm sddm lightdm
sudo systemctl enable greetd
```

#### Syncing themes (Optional)

To sync your wallpaper and theme with the greeter login screen, follow the manual setup below:

<details>
<summary>Manual theme syncing</summary>

```bash
# Add yourself to greeter group
sudo usermod -aG greeter <username>

# Set ACLs to allow greeter to traverse your directories
setfacl -m u:greeter:x ~ ~/.config ~/.local ~/.cache ~/.local/state

# Set group ownership on config directories
sudo chgrp -R greeter ~/.config/BuckMaterialShell
sudo chgrp -R greeter ~/.local/state/BuckMaterialShell  
sudo chgrp -R greeter ~/.cache/quickshell
sudo chmod -R g+rX ~/.config/BuckMaterialShell ~/.local/state/BuckMaterialShell ~/.cache/quickshell

# Create symlinks
sudo ln -sf ~/.config/BuckMaterialShell/settings.json /var/cache/dykwabi-greeter/settings.json
sudo ln -sf ~/.local/state/BuckMaterialShell/session.json /var/cache/dykwabi-greeter/session.json
sudo ln -sf ~/.cache/BuckMaterialShell/dykwabi-colors.json /var/cache/dykwabi-greeter/colors.json

# Logout and login for group membership to take effect
```

</details>

### Fedora / RHEL / Rocky / Alma

Install from COPR or build the RPM:

```bash
# From COPR (when available)
sudo dnf copr enable avenge/dykwabi
sudo dnf install dykwabi-greeter

# Or build locally
cd /path/to/BuckMaterialShell
rpkg local
sudo rpm -ivh x86_64/dykwabi-greeter-*.rpm
```

The package automatically:
- Creates the greeter user
- Sets up directories and permissions
- Configures greetd with auto-detected compositor
- Applies SELinux contexts
- Installs the `dykwabi-greeter-sync` helper script

Then disable existing display manager and enable greetd:

```bash
sudo systemctl disable gdm sddm lightdm
sudo systemctl enable greetd
```

#### Syncing themes (Optional)

The RPM package includes the `dykwabi-greeter-sync` helper for easy theme syncing:

```bash
dykwabi-greeter-sync
```

Then logout/login to see your wallpaper on the greeter!

<details>
<summary>What does dykwabi-greeter-sync do?</summary>

The `dykwabi-greeter-sync` helper automatically:
- Adds you to the greeter group
- Sets minimal ACL permissions on parent directories (traverse only)
- Sets group ownership on your Dykwabi config directories
- Creates symlinks to share your theme files with the greeter

This uses standard Linux ACLs (Access Control Lists) - the same security model used by GNOME, KDE, and systemd. The greeter user only gets traverse permission through your directories and can only read the specific theme files you share.

</details>

### Automatic

The easiest thing is to run `dykwabi greeter install` or `dykwabi` for interactive installation.

### Manual

1. Install `greetd` (in most distro's standard repositories) and `quickshell`

2. Create the greeter user (if not already created by greetd):
```bash
sudo groupadd -r greeter
sudo useradd -r -g greeter -d /var/lib/greeter -s /bin/bash -c "System Greeter" greeter
sudo mkdir -p /var/lib/greeter
sudo chown greeter:greeter /var/lib/greeter
```

3. Clone the dykwabi project to `/etc/xdg/quickshell/dykwabi-greeter`:
```bash
sudo git clone https://github.com/AvengeMedia/BuckMaterialShell.git /etc/xdg/quickshell/dykwabi-greeter
```

4. Copy `Modules/Greetd/assets/dykwabi-greeter` to `/usr/local/bin/dykwabi-greeter`:
```bash
sudo cp /etc/xdg/quickshell/dykwabi-greeter/Modules/Greetd/assets/dykwabi-greeter /usr/local/bin/dykwabi-greeter
sudo chmod +x /usr/local/bin/dykwabi-greeter
```

5. Create greeter cache directory with proper permissions:
```bash
sudo mkdir -p /var/cache/dykwabi-greeter
sudo chown greeter:greeter /var/cache/dykwabi-greeter
sudo chmod 750 /var/cache/dykwabi-greeter
```

6. Edit or create `/etc/greetd/config.toml`:
```toml
[terminal]
vt = 1

[default_session]
user = "greeter"
# Change compositor to sway or hyprland if preferred
command = "/usr/local/bin/dykwabi-greeter --command niri"
```

7. Disable existing display manager and enable greetd:
```bash
sudo systemctl disable gdm sddm lightdm
sudo systemctl enable greetd
```

8. (Optional) Set up theme syncing using the manual ACL method described in the Configuration → Personalization section below

#### Legacy installation (deprecated)

If you prefer the old method with separate shell scripts and config files:
1. Copy `assets/dykwabi-niri.kdl` or `assets/dykwabi-hypr.conf` to `/etc/greetd`
2. Copy `assets/greet-niri.sh` or `assets/greet-hyprland.sh` to `/usr/local/bin/start-dykwabi-greetd.sh`
3. Edit the config file and replace `_DYKWABI_PATH_` with your Dykwabi installation path
4. Configure greetd to use `/usr/local/bin/start-dykwabi-greetd.sh`

### NixOS

To install the greeter on NixOS add the repo to your flake inputs as described in the readme. Then somewhere in your NixOS config add this to imports:
```nix
imports = [
  inputs.buckMaterialShell.nixosModules.greeter
]
```

Enable the greeter with this in your NixOS config:
```nix
programs.buckMaterialShell.greeter = {
  enable = true;
  compositor.name = "niri"; # or set to hyprland
  configHome = "/home/user"; # optionally copyies that users Dykwabi settings (and wallpaper if set) to the greeters data directory as root before greeter starts
};
```

## Usage

### Using dykwabi-greeter wrapper (recommended)

The `dykwabi-greeter` wrapper simplifies running the greeter with any compositor:

```bash
dykwabi-greeter --command niri
dykwabi-greeter --command hyprland
dykwabi-greeter --command sway
dykwabi-greeter --command niri -C /path/to/custom-niri.kdl
```

Configure greetd to use it in `/etc/greetd/config.toml`:
```toml
[terminal]
vt = 1

[default_session]
user = "greeter"
command = "/usr/local/bin/dykwabi-greeter --command niri"
```

### Manual usage

To run dykwabi in greeter mode you can also manually set environment variables:

```bash
DYKWABI_RUN_GREETER=1 qs -p /path/to/dykwabi
```

### Configuration

#### Compositor

You can configure compositor specific settings such as outputs/displays the same as you would in niri or Hyprland.

Simply edit `/etc/greetd/dykwabi-niri.kdl` or `/etc/greetd/dykwabi-hypr.conf` to change compositor settings for the greeter

#### Personalization

The greeter can be personalized with wallpapers, themes, weather, clock formats, and more - configured exactly the same as dykwabi.

**Easiest method:** Run `dykwabi-greeter-sync` to automatically sync your Dykwabi theme with the greeter.

**Manual method:** You can manually synchronize configurations if you want greeter settings to always mirror your shell:

```bash
# Add yourself to the greeter group
sudo usermod -aG greeter $USER

# Set ACLs to allow greeter user to traverse your home directory
setfacl -m u:greeter:x ~ ~/.config ~/.local ~/.cache ~/.local/state

# Set group permissions on Dykwabi directories
sudo chgrp -R greeter ~/.config/BuckMaterialShell ~/.local/state/BuckMaterialShell ~/.cache/quickshell
sudo chmod -R g+rX ~/.config/BuckMaterialShell ~/.local/state/BuckMaterialShell ~/.cache/quickshell

# Create symlinks for theme files
sudo ln -sf ~/.config/BuckMaterialShell/settings.json /var/cache/dykwabi-greeter/settings.json
sudo ln -sf ~/.local/state/BuckMaterialShell/session.json /var/cache/dykwabi-greeter/session.json
sudo ln -sf ~/.cache/BuckMaterialShell/dykwabi-colors.json /var/cache/dykwabi-greeter/colors.json

# Logout and login for group membership to take effect
```

**Advanced:** You can override the configuration path with the `DYKWABI_GREET_CFG_DIR` environment variable or the `--cache-dir` flag when using `dykwabi-greeter`. The default is `/var/cache/dykwabi-greeter`.

The cache directory should be owned by `greeter:greeter` with `770` permissions.
