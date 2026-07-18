{ ... }: {
  programs.yazi.enable = true;

  my.r.yazi = ''
    yazi "$@"
  '';
}
