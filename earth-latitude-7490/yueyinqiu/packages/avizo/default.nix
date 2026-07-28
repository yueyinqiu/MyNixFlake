{ ... }: {
  services.avizo.enable = true;

  my.navi-cheats.avizo = ''
    $ direction: printf "up\ndown\n" --- --map my-bash-escape-std

    # adjust speaker volume with avizo notification
    volumectl -u <direction>

    # toggle speaker mute state with avizo notification
    volumectl toggle-mute

    # toggle microphone mute state with avizo notification
    volumectl -m toggle-mute

    # adjust screen brightness with avizo notification
    lightctl <direction>
  '';
}
