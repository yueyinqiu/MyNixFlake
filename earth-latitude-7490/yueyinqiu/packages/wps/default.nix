{ pkgs, ... }: {
  # https://github.com/Beriholic/nix-wpsoffice-cn/issues/1#issuecomment-3706931491
  # https://bbs.wps.cn/topic/61831
  # Don't Login! It will create a fucking Documents directory!
  my.r.wps = ''
    GTK_IM_MODULE="fcitx" QT_IM_MODULE="fcitx" SDL_IM_MODULE="fcitx" HOME="$HOME/.wps" ${pkgs.wpsoffice-cn}/bin/wps
  '';
  my.navi-cheats.wechat = ''
    # run wps, a free all-in-one office suite for Microsoft Word, Excel, PowerPoint, and PDF files.
    r wps
  '';
}
