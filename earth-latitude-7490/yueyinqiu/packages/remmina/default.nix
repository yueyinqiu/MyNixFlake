{ pkgs, ... }: {
  services.remmina.enable = true;

  my.r.remmina = ''
    remmina
  '';
}
