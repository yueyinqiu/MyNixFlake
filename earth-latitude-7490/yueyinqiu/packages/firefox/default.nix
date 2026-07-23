{ ... }: {
  programs.firefox.enable = true;

  my.r.firefox = "firefox";
  my.r.f = "r firefox-niri-spawn";
  my.r.firefox-niri-spawn = "niri msg action spawn -- firefox";

  my.sing-box.instances.for-firefox = {
    files = [
      ./rules.json
    ];
    port = 14469;
    manager = 53507;
  };
}
