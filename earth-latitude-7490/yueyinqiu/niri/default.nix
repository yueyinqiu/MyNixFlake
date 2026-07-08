{ pkgs, ... }: {
    xdg.configFile."niri/config-binds.kdl".source = ./config-binds.kdl;
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
}