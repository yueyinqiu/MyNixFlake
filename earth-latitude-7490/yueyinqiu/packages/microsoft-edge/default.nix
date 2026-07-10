{ pkgs, ... }: {
    home.packages = with pkgs; [
        microsoft-edge
    ];
    my.r.e = "microsoft-edge --proxy-server=localhost:7890";
}