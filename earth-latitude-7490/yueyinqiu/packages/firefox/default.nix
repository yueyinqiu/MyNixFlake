{ pkgs, ... }: {
  programs.firefox.enable = true;

  my.sing-box.instances.for-firefox = {
    files = [
      ./rules.json
    ];
    port = 14469;
    manager = 53507;
  };

  home.packages = [
    (pkgs.writeShellApplication {
      name = "f";
      text = ''
        niri msg action spawn -- firefox
      '';
    })
  ];

  my.navi-cheats.firefox = ''
    # spawn firefox via niri, detached from current shell
    f
  '';
}
