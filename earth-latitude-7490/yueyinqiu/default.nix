{ pkgs, lib, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;

    home.sessionVariables = {
        PS1 = "\\[\\033[1;32m\\][\\[\\e]0;\\u@earth: \\w\\a\\]\\u@earth:\\W]\\$\\[\\033[0m\\] ";
    };

    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        corefonts
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