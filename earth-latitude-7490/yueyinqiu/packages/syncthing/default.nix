{ ... }: {
  services.syncthing.enable = true;
  services.syncthing.guiAddress = "127.0.0.1:32775";

  my.navi-cheats = [
    ''
      % syncthing

      # open syncthing web ui in default browser
      syncthing cli config gui raw-address get
    ''
  ];
}
