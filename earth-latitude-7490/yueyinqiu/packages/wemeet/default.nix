{ pkgs, ... }: {
    services.flatpak.packages = [
        "com.tencent.wemeet"
    ];
    my.r.wemeet = "flatpak run com.tencent.wemeet";
}