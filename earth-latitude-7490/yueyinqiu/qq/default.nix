{ ... }: {
    services.flatpak.packages = [
        "com.qq.QQ"
    ];
    my.run.entries.qq = "flatpak run com.qq.QQ";
}