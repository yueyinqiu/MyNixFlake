{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixfmt
  ];
  my.r.nixfmt = ''
    nixfmt "$@"
  '';
}
