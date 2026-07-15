{ ... }: {
  services.mako.enable = true;
  my.r.mako-history = ''
    makoctl history -j
  '';
}
