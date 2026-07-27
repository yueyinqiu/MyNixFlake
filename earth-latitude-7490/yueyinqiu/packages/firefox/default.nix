{ ... }: {
  programs.firefox.enable = true;

  my.r.f = "niri msg action spawn -- firefox";

  my.sing-box.instances.for-firefox = {
    files = [
      ./rules.json
    ];
    port = 14469;
    manager = 53507;
  };
}
