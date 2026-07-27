{ ... }: {
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    confirm-close-surface = false;
  };
}
