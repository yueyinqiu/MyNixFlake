{ ... }: {
    services.flatpak.packages = [
        "com.tencent.WeChat"
    ];
    my.run.entries.wechat = "flatpak run com.tencent.WeChat";
}