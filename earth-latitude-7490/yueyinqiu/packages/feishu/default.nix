{ pkgs, ... }: {
  home.packages = with pkgs; [
    feishu
  ];

  my.r.feishu = ''
    feishu
  '';
}
