{ pkgs, ... }: {
  home.packages = with pkgs; [
    xwayland-satellite
  ];
  my.navi-cheats.xwayland-satellite = ''
    # run wps, which grants rootless Xwayland integration to any Wayland compositor implementing xdg_wm_base and viewporter.
    xwayland-satellite
  '';
}
