{ pkgs, ... }: {
  home.packages = with pkgs; [
    htop
  ];
  my.r.htop = ''
    htop
  '';
}
