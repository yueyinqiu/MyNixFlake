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
        microsoft-edge
    ];
    
    programs.fuzzel.enable = true;
    nixpkgs.config.allowUnfree = true;
    programs.vscode.enable = true;
}