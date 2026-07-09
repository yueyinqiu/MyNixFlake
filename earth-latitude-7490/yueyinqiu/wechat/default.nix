{ ... }: {
    services.flatpak.packages = [
        "com.tencent.WeChat"
    ];
    my.r.wechat = "flatpak run com.tencent.WeChat";
}