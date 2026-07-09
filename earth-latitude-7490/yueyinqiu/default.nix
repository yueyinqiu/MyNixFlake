{ pkgs, lib, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
    ];

    fonts.fontconfig.enable = true;

    fonts.fontconfig.defaultFonts = {
        serif = [ "Noto Serif CJK SC" ];
        sansSerif = [ "Noto Sans CJK SC" ];
    };
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