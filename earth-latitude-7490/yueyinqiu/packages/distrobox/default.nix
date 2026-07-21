{ pkgs, ... }: {
  home.packages = with pkgs; [
    distrobox
  ];

  my.r.distrobox = ''
    distrobox
  '';
}
