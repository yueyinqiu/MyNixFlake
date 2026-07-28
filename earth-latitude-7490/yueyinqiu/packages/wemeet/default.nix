{ ... }: {
  services.flatpak.packages = [
    "flathub:app/com.tencent.wemeet/x86_64/stable"
  ];

  my.navi-cheats.wemeet = ''
    # run wemeet, namely, Tencent video conferencing.
    flatpak run com.tencent.wemeet
  '';
}
