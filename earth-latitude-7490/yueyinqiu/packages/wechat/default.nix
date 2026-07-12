{ pkgs, ... }: {
    home.packages = with pkgs; [
        wechat
    ];
    my.r.wechat = "wechat";
}