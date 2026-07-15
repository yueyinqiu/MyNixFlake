{ pkgs, ... }: {
  my.r.mpv = ''
    "${pkgs.mpv}/bin/mpv" "$@"
  '';
}
