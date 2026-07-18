{ pkgs, ... }: {
  home.packages = with pkgs; [
    btop
  ];
  my.r."btop" = ''
    btop
  '';
}
