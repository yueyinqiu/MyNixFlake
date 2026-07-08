{ pkgs, lib, ... }: {
    programs.home-manager.enable = true;
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";
    home.stateVersion = "26.05";
    home.packages = with pkgs; [
        git
    ];
    
    programs.fuzzel.enable = true;
    programs.foot.enable = true;
    
    home.packages = with pkgs; [
        fcitx5
        fcitx5-chinese-addons
        fcitx5-rime
        fcitx5-gtk
    ];

    home.sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
    };

    nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
            "vscode"
        ];
    programs.vscode.enable = true;
}