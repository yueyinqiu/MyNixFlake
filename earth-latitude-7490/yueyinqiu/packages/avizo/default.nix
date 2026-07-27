{ ... }: {
  services.avizo.enable = true;

  my.navi-cheats = [
    ''
      % avizo

      # adjust speaker volume with avizo notification
      volumectl -u "<direction>"

      $ direction: printf "up\ndown\n"
    ''
    ''
      % avizo

      # toggle speaker mute state with avizo notification
      volumectl toggle-mute
    ''
    ''
      % avizo

      # toggle microphone mute state with avizo notification
      volumectl -m toggle-mute
    ''
    ''
      % avizo

      # adjust screen brightness with avizo notification
      lightctl "<direction>"
      $ direction: printf "up\ndown\n"
    ''
  ];
}
