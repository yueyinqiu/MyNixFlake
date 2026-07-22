{ pkgs, ... }: {
  home.packages = with pkgs; [
    remmina
  ];

  my.r.remmina = ''
    remmina
  '';
}
