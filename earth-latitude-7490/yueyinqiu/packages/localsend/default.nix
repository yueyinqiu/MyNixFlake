{ pkgs, ... }: {
  home.packages = with pkgs; [
    localsend
  ];

  my.r.localsend = ''
    localsend "$@"
  '';
}
