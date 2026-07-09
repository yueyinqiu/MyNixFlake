{ pkgs, ... }: {
    programs.bash = {
        enable = true;
        profileExtra = ''
            if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
                niri-session
            fi
        '';
    };
}
