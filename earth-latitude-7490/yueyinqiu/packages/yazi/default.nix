{ ... }: {
  programs.yazi.enable = true;
  programs.yazi.enableBashIntegration = true;
  my.r.yazi = ''
    y "$@"
  '';
}
