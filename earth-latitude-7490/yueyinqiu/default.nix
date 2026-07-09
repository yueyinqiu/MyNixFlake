{ pkgs, lib, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;
    imports = [
        ./fcitx5
        ./flclash
        ./flatpak
        ./fuzzel
        ./microsoft-edge
        ./run
        ./vscode
        ./wechat
        ./qq
        ./_7zz
        ./opencode
        ./alacritty
        ./git
        ./niri
        ./xwayland-satellite
    ];

    home.stateVersion = "26.05";
}