{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixd
  ];
  my.r.nixd = ''
    nixd "$@"
  '';
}
