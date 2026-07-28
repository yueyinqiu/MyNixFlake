{ ... }: {
  programs.ghostty.enable = true;
  programs.ghostty.settings = {
    confirm-close-surface = false;
    shell-integration-features = "ssh-env";
  };
  
  my.navi-cheats.ghostty = ''
    # run ghostty, a fast, feature-rich, and cross-platform terminal emulator that uses platform-native UI and GPU acceleration.
    ghostty
  '';
}
