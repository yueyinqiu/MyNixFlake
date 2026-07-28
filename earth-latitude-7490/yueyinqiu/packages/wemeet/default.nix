{ ... }: {
  services.flatpak.packages = [
    "flathub:app/com.tencent.wemeet/x86_64/stable"
  ];
  my.r.wemeet = "flatpak run com.tencent.wemeet";

  my.navi-cheats.wechat = ''
    # run wemeet, namely, Tencent video conferencing.
    r wemeet
  '';
}
