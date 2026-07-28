{ pkgs, ... }: {
  home.packages = with pkgs; [
    feishu
  ];

  my.navi-cheats.feishu = ''
    # run feishu, a new way to collaborate, empowering teams by messenger, meetings, calendar, docs, and emails.
    bytedance-feishu
  '';
}
