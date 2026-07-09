{ pkgs, lib, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        noto-fonts-monospace
    ];

    fonts.fontconfig.enable = true;

    fonts.fontconfig.defaultFonts = {
        serif = [ "Noto Serif" "Noto Serif CJK SC" ];
        sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
        monospace = [ "Noto Sans Mono" "Noto Sans CJK SC" ];
    };

    imports = [ ./packages ];

    home.stateVersion = "26.05";
}