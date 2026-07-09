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
    ];

    fonts.fontconfig = {
        enable = true;

        antialiasing = true;
        hinting = "full";
        subpixelRendering = "rgb";

        defaultFonts = {
            serif = [ "Noto Serif CJK SC" ];
            sansSerif = [ "Noto Sans CJK SC" ];
        };
    };

    imports = [ ./packages ];

    home.stateVersion = "26.05";
}