{ ... }: {
  services.syncthing.enable = true;
  services.syncthing.guiAddress = "127.0.0.1:32775";
  my.r.syncthing-webui = ''
    echo "http://127.0.0.1:32775"
  '';
}
