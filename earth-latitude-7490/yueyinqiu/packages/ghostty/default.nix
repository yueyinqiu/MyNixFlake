{ ... }: {
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    confirm-close-surface = false;
  };

  my.r.ghostty = ''
    ghostty "$@"
  '';
}
