{ pkgs, ... }: {
  # https://github.com/Beriholic/nix-wpsoffice-cn/issues/1#issuecomment-3706931491
  # https://bbs.wps.cn/topic/61831
  # Don't Login! It will create a fucking Documents directory!

  home.packages = [
    (pkgs.symlinkJoin {
      name = "wps-fcitx-fake-home";
      paths = [ pkgs.wpsoffice-cn ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/wps \
          --set GTK_IM_MODULE "fcitx" \
          --set QT_IM_MODULE "fcitx" \
          --set SDL_IM_MODULE "fcitx" \
          --set HOME "$HOME/.wps"
      '';
    })
  ];
  
  my.navi-cheats.wps = ''
    # run wps, a free all-in-one office suite for Microsoft Word, Excel, PowerPoint, and PDF files.
    wps
  '';
}
