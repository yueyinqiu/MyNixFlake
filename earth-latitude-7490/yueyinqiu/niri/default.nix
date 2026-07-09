{ pkgs, ... }: {
    xdg.configFile."niri/config-binds.kdl".source = ./config-binds.kdl;
    xdg.configFile."niri/config-spawn-at-startup.kdl".source = ./config-spawn-at-startup.kdl;
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
    xdg.configFile."niri/spawn-at-startup.sh" = {
        source = ./spawn-at-startup.sh;
        executable = true;
    };
}