{ niri, ... }: {
  imports = [
    niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    settings = {
      screenshot-path = null;

      input = {
        keyboard.numlock = true;
        touchpad = {
          tap = true;
          natural-scroll = true;
          scroll-factor = 0.4;
        };
      };

      window-rules = [
        {
          match.app-id = "com.mitchellh.ghostty";
          open-maximized-to-edges = true;
        }
      ];

      spawn-at-startup = [
        { sh = "ghostty --command=\"r expect-bash-run r sing-box-nix-daemon-proxy\""; }
        { sh = "ghostty --command=\"r expect-bash-run nix-daemon-proxy socks5h://127.0.0.1:23569\""; }
        { argv = [ "FlClash" ]; }
        { argv = [ "qq" ]; }
        { sh = "r wechat"; }
      ];

      binds = {
        "Mod+W".hotkey-overlay.title = "Terminal";
        "Mod+W".action.spawn-sh = "ghostty --working-directory=\"$HOME\"";

        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "r avizo-speaker-up";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "r avizo-speaker-down";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "r avizo-speaker-mute";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "r avizo-microphone-mute";
        };

        "XF86AudioPlay" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "playerctl play-pause";
        };
        "XF86AudioStop" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "playerctl stop";
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "playerctl previous";
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "playerctl next";
        };

        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "r avizo-light-up";
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          hotkey-overlay.hidden = true;
          action.spawn-sh = "r avizo-light-down";
        };
      };
    };
  };

  my.r.n = "niri-session";
  my.r.niri = "niri-session";
}
