{ pkgs, ... }: {
  home.packages = with pkgs; [
    feishu
  ];

  my.r.feishu = ''
    bytedance-feishu
  '';
}
