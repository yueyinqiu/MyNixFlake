{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
  ];
  my.navi-cheats = [
    ''
      % htop

      # run htop, a cross-platform interactive process viewer.
      htop
    ''
  ];
}
