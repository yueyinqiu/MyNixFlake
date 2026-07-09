{ config, lib, pkgs, ... }: {
    imports = [
        ./hardware.nix
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  
    networking.hostName = "earth-latitude-7490";
    networking.networkmanager.enable = true;
  
    time.timeZone = "Asia/Shanghai";
  
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
  
    services.openssh.enable = true;
    programs.niri.enable = true;
    services.flatpak.enable = true;

    system.stateVersion = "26.05";  # never change this, even it's updated
}