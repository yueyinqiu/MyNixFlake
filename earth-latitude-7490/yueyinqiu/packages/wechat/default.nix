{ pkgs, ... }: {
    home.packages = [
        (import ./package.nix {
            appimageTools = pkgs.appimageTools;
            fetchurl = pkgs.fetchurl;
        })
    ];
    my.r.wechat = "wechat";
}
