{ pkgs, ... }: {
    xdg.configFile."niri/config-binds.kdl".source = ./config-binds.kdl;
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."niri/spawn-at-startup.sh" = {
        source = ./spawn-at-startup.sh;
        executable = true;
    };
    my.r.niri = "niri-session";
}