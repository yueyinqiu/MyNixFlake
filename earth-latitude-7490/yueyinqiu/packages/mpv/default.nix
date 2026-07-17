{ pkgs, ... }: {
  home.packages = with pkgs; [
    mpv
  ];
  my.r.mpv = ''
    mpv "$@"
  '';
}
