{
    config,
    lib,
    ...
}: let
    cfg = config.programs.buckMaterialShell;
in {
    options.programs.buckMaterialShell = {
        niri = {
            enableKeybinds = lib.mkEnableOption "BuckMaterialShell niri keybinds";
            enableSpawn = lib.mkEnableOption "BuckMaterialShell niri spawn-at-startup";
        };
    };

    config = lib.mkIf cfg.enable {
        programs.niri.settings = lib.mkMerge [
            (lib.mkIf cfg.niri.enableKeybinds {
                binds = with config.lib.niri.actions; let
                    dykwabi-ipc = spawn "dykwabi" "ipc";
                in
                    {
                        "Mod+Space" = {
                            action = dykwabi-ipc "spotlight" "toggle";
                            hotkey-overlay.title = "Toggle Application Launcher";
                        };
                        "Mod+N" = {
                            action = dykwabi-ipc "notifications" "toggle";
                            hotkey-overlay.title = "Toggle Notification Center";
                        };
                        "Mod+Comma" = {
                            action = dykwabi-ipc "settings" "toggle";
                            hotkey-overlay.title = "Toggle Settings";
                        };
                        "Mod+P" = {
                            action = dykwabi-ipc "notepad" "toggle";
                            hotkey-overlay.title = "Toggle Notepad";
                        };
                        "Super+Alt+L" = {
                            action = dykwabi-ipc "lock" "lock";
                            hotkey-overlay.title = "Toggle Lock Screen";
                        };
                        "Mod+X" = {
                            action = dykwabi-ipc "powermenu" "toggle";
                            hotkey-overlay.title = "Toggle Power Menu";
                        };
                        "XF86AudioRaiseVolume" = {
                            allow-when-locked = true;
                            action = dykwabi-ipc "audio" "increment" "3";
                        };
                        "XF86AudioLowerVolume" = {
                            allow-when-locked = true;
                            action = dykwabi-ipc "audio" "decrement" "3";
                        };
                        "XF86AudioMute" = {
                            allow-when-locked = true;
                            action = dykwabi-ipc "audio" "mute";
                        };
                        "XF86AudioMicMute" = {
                            allow-when-locked = true;
                            action = dykwabi-ipc "audio" "micmute";
                        };
                        "Mod+Alt+N" = {
                            allow-when-locked = true;
                            action = dykwabi-ipc "night" "toggle";
                            hotkey-overlay.title = "Toggle Night Mode";
                        };
                    }
                    // lib.attrsets.optionalAttrs cfg.enableSystemMonitoring {
                        "Mod+M" = {
                            action = dykwabi-ipc "processlist" "toggle";
                            hotkey-overlay.title = "Toggle Process List";
                        };
                    }
                    // lib.attrsets.optionalAttrs cfg.enableClipboard {
                        "Mod+V" = {
                            action = dykwabi-ipc "clipboard" "toggle";
                            hotkey-overlay.title = "Toggle Clipboard Manager";
                        };
                    }
                    // lib.attrsets.optionalAttrs cfg.enableBrightnessControl {
                        "XF86MonBrightnessUp" = {
                            allow-when-locked = true;
                            action = dykwabi-ipc "brightness" "increment" "5" "";
                        };
                        "XF86MonBrightnessDown" = {
                            allow-when-locked = true;
                            action = dykwabi-ipc "brightness" "decrement" "5" "";
                        };
                    };
            })

            (lib.mkIf cfg.niri.enableSpawn {
                spawn-at-startup =
                    [
                        {command = ["dykwabi" "run"];}
                    ]
                    ++ lib.optionals cfg.enableClipboard [
                        {
                            command = ["wl-paste" "--watch" "cliphist" "store"];
                        }
                    ];
            })
        ];
    };
}
