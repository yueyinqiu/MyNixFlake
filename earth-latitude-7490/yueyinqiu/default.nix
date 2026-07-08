{ pkgs, lib, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;
    home.packages = with pkgs; [ git ];

    nixpkgs.config.allowUnfree = true;
    imports = [
        ./clash-verge-rev
        ./fcitx5
        ./foot
        ./fuzzel
        ./microsoft-edge
        ./vscode
        ./flclash
    ];

    home.stateVersion = "26.05";
}