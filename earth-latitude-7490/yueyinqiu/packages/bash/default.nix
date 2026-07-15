{ ... }: {
  programs.bash.enable = true;
  my.r."bash" = ''
    bash "$@"
  '';
}
