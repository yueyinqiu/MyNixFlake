{ ... }: {
  programs.obs-studio.enable = true;

  my.navi-cheats.obs-studio = ''
    # run obs-studio, a software designed for capturing, compositing, encoding, recording, and streaming video content, efficiently.
    obs
  '';
}
