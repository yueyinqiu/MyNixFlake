{ pkgs, ... }: {
  home.packages = with pkgs; [
    mpv
  ];
  my.navi-cheats = [
    ''
      % mpv

      # play a video file with mpv
      mpv "<target>"

      $ target: find . -maxdepth 1 -type f
    ''
  ];
}
