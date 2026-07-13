{ pkgs, ... }: {
    # https://zhuanlan.zhihu.com/p/2051087997395808628
    my.r.wechat = ''
        env WAYLAND_DISPLAY= DISPLAY=:0 QT_QPA_PLATFORM=xcb GTK_IM_MODULE=fcitx QT_IM_MODULE=fcitx XMODIFIERS=@im=fcitx "${pkgs.wechat}/bin/wechat"
    '';
}