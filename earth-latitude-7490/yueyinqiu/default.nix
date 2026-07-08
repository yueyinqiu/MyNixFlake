{ pkgs, lib, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;
    home.packages = with pkgs; [ git ];

    nixpkgs.config.allowUnfree = true;
    imports = [
        ./fcitx5
        ./flclash
        ./foot
        ./fuzzel
        ./microsoft-edge
        ./qq
        ./vscode
        ./wechat
    ];

    home.stateVersion = "26.05";
}