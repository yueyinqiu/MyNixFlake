{ config, lib, pkgs, winapps, ... }: {
    imports = [
        ./hardware.nix
    ];

    boot.loader.grub.enable = true;
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.device = "nodev";

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
  
    users.users.yueyinqiu = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };
  
    environment.systemPackages = [ winapps.packages."x86_64-linux".winapps ];

    services.openssh.enable = true;
    programs.niri.enable = true;
    services.flatpak.enable = true;

    system.stateVersion = "26.05";  # never change this, even it's updated
}