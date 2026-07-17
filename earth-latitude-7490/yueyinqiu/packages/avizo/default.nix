{ ... }: {
  services.avizo.enable = true;

  my.r.avizo-speaker-up = ''
    volumectl -u up
  '';
  my.r.avizo-speaker-down = ''
    volumectl -u down
  '';
  my.r.avizo-speaker-mute = ''
    volumectl toggle-mute
  '';
  my.r.avizo-microphone-mute = ''
    volumectl -m toggle-mute
  '';
  my.r.avizo-light-up = ''
    lightctl up
  '';
  my.r.avizo-light-down = ''
    lightctl down
  '';
}
