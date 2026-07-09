{ pkgs, lib, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;
    imports = [
        ./fcitx5
        ./flclash
        ./flatpak
        ./foot
        ./fuzzel
        ./microsoft-edge
        ./vscode
        ./wechat
        ./qq
        ./_7zz
        ./opencode
        ./alacritty
        ./git
        ./niri
    ];

    home.stateVersion = "26.05";
}