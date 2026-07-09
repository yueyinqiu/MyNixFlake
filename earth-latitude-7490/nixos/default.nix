{ config, lib, pkgs, winapps, ... }: {
    imports = [
        ./hardware.nix
        ./beyond-tunnel
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "earth-latitude-7490";
    networking.networkmanager.enable = true;
  
    time.timeZone = "Asia/Shanghai";
  
    i18n.defaultLocale = "en_US.UTF-8";

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
    ];
    
    swapDevices = [
        {
            device = "/swap/swapfile";
            size = 8192;
        }
    ];
    virtualisation = {
        containers.enable = true;
        podman = {
            enable = true;
            dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
        };
    };

    users.users.yueyinqiu = {
        isNormalUser = true;
        extraGroups = [ "wheel" "podman" ];
    };
  
    environment.systemPackages = [ winapps.packages."x86_64-linux".winapps ];

    services.beyond-tunnel.enable = true;
    services.openssh.enable = true;
    programs.niri.enable = true;
    services.flatpak.enable = true;

    systemd.services."getty@tty1" = {
        serviceConfig.ExecStart = [
            ""
            "${pkgs.util-linux}/bin/agetty -l ${pkgs.writeShellScript "login-yueyinqiu" ''
                exec /run/current-system/sw/bin/login yueyinqiu
            ''} %I $TERM"
        ];
    };

    system.stateVersion = "26.05";  # never change this, even it's updated
}