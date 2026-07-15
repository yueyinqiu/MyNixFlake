{ pkgs, ... }: {
  my.r.ghostty = ''
    "${pkgs.ghostty}/bin/ghostty" "$@"
  '';
}
