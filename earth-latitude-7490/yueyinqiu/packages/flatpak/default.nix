{ flatpaks, ... }: {
    imports = [
        flatpaks.homeModules.default
    ];

    services.flatpak = {
        enable = true;
        remotes = {
            "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        };
    };
}

# { pkgs, ... }: {
#     services.flatpak.packages = [
#         "flathub:app/com.tencent.wemeet/x86_64/stable"
#     ];
#     my.r.wemeet = "flatpak run com.tencent.wemeet";
# }