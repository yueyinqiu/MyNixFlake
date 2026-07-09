{ pkgs, nix-flatpak, ... }: {
    imports = [
        nix-flatpak.homeManagerModules.nix-flatpak
    ];

    services.flatpak = {
        enable = true;
        uninstallUnmanaged = true;
        remotes = [
            {
                name = "flathub";
                location = "https://mirrors.ustc.edu.cn/flathub/";
            }
        ];
    };
}
