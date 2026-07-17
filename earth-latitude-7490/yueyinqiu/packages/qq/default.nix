{ pkgs, ... }: {
  home.packages = with pkgs; [
    qq
  ];

  my.r.qq = ''
    qq
  '';
}
