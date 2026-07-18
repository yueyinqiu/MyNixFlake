{ pkgs, ... }: {
  home.packages = with pkgs; [
    freerdp
  ];

  my.r.rdp = ''
    xfreerdp "$@"
  '';
}
