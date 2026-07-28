{ pkgs, ... }: {
  home.packages = [
    (pkgs.symlinkJoin {
      name = "wechat-fcitx";
      paths = [ pkgs.wechat ];
      buildInputs = [ pkgs.makeWrapper ];

      # https://zhuanlan.zhihu.com/p/2051087997395808628
      postBuild = ''
        wrapProgram $out/bin/wechat \
          --unset WAYLAND_DISPLAY \
          --set DISPLAY ":0" \
          --set QT_QPA_PLATFORM "xcb" \
          --set GTK_IM_MODULE "fcitx" \
          --set QT_IM_MODULE "fcitx" \
          --set XMODIFIERS "@im=fcitx"
      '';
    })
  ];

  my.navi-cheats.wechat = ''
    # run wechat, a social communication app serving over 1 billion users, supporting free chat, HD voice and video calls, Moments, and mobile payments, making communication and life more convenient.
    wechat
  '';
}
