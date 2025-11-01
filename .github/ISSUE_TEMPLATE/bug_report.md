---
name: Bug Report
about: Crashes or unexpected behaviors
title: ""
labels: "bug"
assignees: ""
---

<!-- If your issue is related to ICONS 
- Purple and black checkerboards are QT's way of signalling an icon doesn't exist
  - FIX: Configure a QT6 or Icon Pack in Dykwabi Settings that has the icon you want
  - Follow the [THEMING](https://github.com/AvengeMedia/BuckMaterialShell/tree/master?tab=readme-ov-file#theming) section to ensure your QT environment variable is configured correctl for themes.
  - Once done, configure an icon theme - either however you normally do with gtk3 or qt6ct, or through the built-in settings modal. -->

<!-- If your issue is related to APP LAUNCHER/DOCK/Running Apps being stale
 Quickshell does not ever update its DesktopEntires.
 There is an open PR for it, that has been stuck unmerged over there to fix it.
 We unfortunately are at the mercy of quickshell to merge it.
 Until then, newly installed and removed apps will not react until the
 shell is restarted.
  -->

## Compositor

- [ ] niri
- [ ] Hyprland
- [ ] dwl (MangoWC)
- [ ] sway
- [ ] Other (specify)

## Distribution

<!-- Arch, Fedora, Debian, etc. -->

## dykwabi version

<!-- Output of dykwabi version command -->

## Description

<!-- Brief description of the issue -->

## Expected Behavior

<!-- Describe what you expected to happen -->

## Steps to Reproduce

<!-- Please provide detailed steps to reproduce the issue -->

1.
2.
3.

## Error Messages/Logs

<!-- Please include any error messages, stack traces, or relevant logs -->
<!-- you can get a log file with the following steps:
dykwabi kill
mkdir ~/dykwabi_logs
nohup dykwabi run > ~/dykwabi_logs/dykwabi-$(date +%s).txt 2>&1 &

Then trigger your issue, and share the contents of ~/dykwabi_logs/dykwabi-<timestamp>.txt

-->

```
Paste error messages or logs here
```

## Screenshots/Recordings

<!-- If applicable, add screenshots or screen recordings -->