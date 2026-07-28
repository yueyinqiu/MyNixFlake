{ ... }: {
  programs.firefox.enable = true;

  my.sing-box.instances.for-firefox = {
    files = [
      ./rules.json
    ];
    port = 14469;
    manager = 53507;
  };

  my.r.f = "niri msg action spawn -- firefox";

  my.navi-cheats.firefox = ''
    # spawn firefox via niri, detached from current shell
    niri msg action spawn -- firefox
  '';
}
