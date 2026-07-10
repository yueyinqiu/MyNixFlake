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
    
    boot.supportedFilesystems = [ "ntfs" ];

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

    services.greetd = {
        enable = true;
        settings.default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --remember --cmd ${pkgs.bash}/bin/bash";
        };
    };

    users.users.yueyinqiu = {
        isNormalUser = true;
        extraGroups = [ "wheel" "podman" ];
    };
  
    environment.systemPackages = [ winapps.packages."x86_64-linux".winapps ];

    services.beyond-tunnel.enable = true;
    services.openssh.enable = true;
    services.udisks2.enable = true;
    programs.niri.enable = true;
    services.flatpak.enable = true;

    system.stateVersion = "26.05";  # never change this, even it's updated
}