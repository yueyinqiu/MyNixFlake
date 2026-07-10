{ pkgs, flatpaks, ... }: {
    imports = [
        flatpaks.homeModules.default
    ];

    services.flatpak = {
        enable = true;
        remotes = {
            "flathub" = "https://mirror.sjtu.edu.cn/flathub/flathub.flatpakrepo";
        };
        preInstallCommand = ''
            flatpak --user remote-modify flathub --url=https://mirror.sjtu.edu.cn/flathub
        '';
    };
}
