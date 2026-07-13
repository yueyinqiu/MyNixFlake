{ config, pkgs, ... }: 
let 
    directory = "sing-box/nix-daemon-proxy";
in
{
    xdg.configFile."${directory}/config.json".source = ./config.json;
    xdg.configFile."${directory}/outbounds.json.example".source = ./outbounds.json.example;
    xdg.configFile."${directory}/rules.json.example".source = ./rules.json.example;

    my.r.nix-daemon-proxy = "${pkgs.sing-box}/bin/sing-box run -C ${config.xdg.configHome}/${directory} -D ${config.xdg.configHome}/${directory}";
    my.r.nix-daemon-proxy-manage = ''
        echo socks5://127.0.0.1:23569
        echo http://127.0.0.1:62751
    '';
}
