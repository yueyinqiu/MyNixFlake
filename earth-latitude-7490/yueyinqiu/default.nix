{ pkgs, lib, ... }: {
    imports = [
        ./fcitx5
        ./foot
    ];

    programs.home-manager.enable = true;
    home.username = "yueyinqiu";
    home.homeDirectory = "/home/yueyinqiu";
    home.stateVersion = "26.05";
    home.packages = with pkgs; [
        git
    ];
    
    programs.fuzzel.enable = true;
    
    nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
            "vscode"
        ];
    programs.vscode.enable = true;
}