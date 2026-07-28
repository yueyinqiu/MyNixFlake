{ pkgs, ... }: {
  home.packages = with pkgs; [
    mpv
  ];
  my.navi-cheats.mpv = ''
    $ target: find . -maxdepth 1 -type f --- --map my-bash-escape-std
    
    # play a video file with mpv
    mpv "<target>"
  '';
}
