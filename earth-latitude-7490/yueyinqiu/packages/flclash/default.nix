{ pkgs, ... }: {
  my.r.flclash = ''
    "${pkgs.flclash}/bin/FlClash"
  '';
}
