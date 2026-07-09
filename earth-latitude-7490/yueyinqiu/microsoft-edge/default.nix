{ pkgs, ... }: {
    home.packages = with pkgs; [
        microsoft-edge
    ];
    my.run.entries.edge = "microsoft-edge --proxy-server=localhost:7890";
}