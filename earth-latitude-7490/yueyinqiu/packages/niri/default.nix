{ pkgs, ... }: {
  xdg.configFile."niri/config-binds.kdl".source = ./config-binds.kdl;
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."niri/spawn-at-startup.sh" = {
    source = ./spawn-at-startup.sh;
    executable = true;
  };

  home.packages = [
    (pkgs.writeShellApplication {
      name = "n";
      text = ''
        niri-session
      '';
    })
  ];

  my.navi-cheats.niri = ''
    # spawn command inside active niri session
    niri msg action spawn -- <command>
  '';
}
