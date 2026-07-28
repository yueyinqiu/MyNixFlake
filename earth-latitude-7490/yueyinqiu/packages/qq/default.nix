{ pkgs, ... }: {
  home.packages = with pkgs; [
    qq
  ];
  my.navi-cheats.qq = ''
    # run qq, an instant messaging and social platform for PC and mobile users.
    qq
  '';
}
