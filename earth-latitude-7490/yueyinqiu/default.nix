{ pkgs, lib, chinese-fonts-overlay, ... }: {
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";

    programs.home-manager.enable = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [ chinese-fonts-overlay.overlays.default ];

    home.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        microsoftPackages.simsun
    ];

    fonts.fontconfig = {
        enable = true;

        antialiasing = true;
        hinting = "full";
        subpixelRendering = "rgb";

        defaultFonts = {
            serif = [ "NSimSun" ];
            sansSerif = [ "NSimSun" ];
            monospace = [ "NSimSun" ];
        };
    };

    imports = [ ./packages ];

    home.stateVersion = "26.05";
}