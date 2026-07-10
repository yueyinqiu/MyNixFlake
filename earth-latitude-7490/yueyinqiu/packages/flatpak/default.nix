{ pkgs, flatpaks, ... }: {
    imports = [
        flatpaks.homeModules.default
    ];

    services.flatpak = {
        enable = true;
        remotes = {
            "flathub" = "https://dl.flathub.org/repo";
        };
    };
}
