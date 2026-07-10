{ pkgs, flatpaks, ... }: {
    imports = [
        flatpaks.homeModules.default
    ];

    services.flatpak = {
        enable = true;
        remotes = {
            "flathub" = "https://mirror.sjtu.edu.cn/flathub/flathub.flatpakrepo";
        };
    };
}
