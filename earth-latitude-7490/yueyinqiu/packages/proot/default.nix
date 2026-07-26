{ pkgs, ... }: {
  home.packages = with pkgs; [
    proot
  ];

  my.r.proot = ''
    proot "$@"
  '';
}