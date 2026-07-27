{ ... }: {
  services.avizo.enable = true;

  my.navi-cheats = [
    ''
      % avizo, audio

      # adjust speaker volume
      volumectl -u "<direction>"

      $ direction: printf "up\ndown\n"
    ''
    ''
      % avizo, audio

      # toggle speaker
      volumectl toggle-mute
    ''
    ''
      % avizo, microphone

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
