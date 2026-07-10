{ pkgs, flatpaks, ... }: {
    imports = [
        flatpaks.homeModules.default
    ];

    services.flatpak = {
        enable = true;
    };
}
