{ ... }: {
    services.flatpak.packages = [
        "flathub:app/com.tencent.WeChat/x86_64/stable"
    ];
    my.r.wechat = "flatpak run com.tencent.WeChat";
}