{ pkgs, ... }: {
  home.packages = with pkgs; [
    mindustry-wayland
  ];
  my.navi-cheats = [
    ''
      % mindustry

      # run mindustry, a sandbox tower-defense game.
      mindustry
    ''
  ];
}
