{ ... }: {
  services.avizo.enable = true;

  my.navi-cheats = [
    ''
      % avizo, volume, speaker

      # adjust speaker volume
      volumectl -u "<direction>"

      $ direction: printf "up\ndown\n"
    ''
    ''
      % avizo, volume, speaker, mute

      # toggle speaker
      volumectl toggle-mute
    ''
    ''
      % avizo, volume, microphone, mute

      # toggle microphone
      volumectl -m toggle-mute
    ''
    ''
      % avizo, brightness

      # adjust brightness
      lightctl "<direction>"
      $ direction: printf "up\ndown\n"
    ''
  ];
}
