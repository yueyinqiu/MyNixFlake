{ pkgs, ... }: {
  home.packages = with pkgs; [
    wps
  ];

  # https://github.com/Beriholic/nix-wpsoffice-cn/issues/1#issuecomment-3706931491
  my.r.wps = ''
    GTK_IM_MODULE="fcitx" QT_IM_MODULE="fcitx" SDL_IM_MODULE="fcitx" wps
  '';
}
