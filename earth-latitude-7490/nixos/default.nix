{ pkgs, nixvirt, ... }: {
  imports = [
    ./hardware.nix
    ./beyond-tunnel
    ./nix-daemon-proxy
    nixvirt.nixosModules.default
    ../../lib/dotnet-build.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "earth-latitude-7490";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.substituters = [
    "https://mirror.nju.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirrors.cernet.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    # "https://mirrors.cqupt.edu.cn/nix-channels/store"
    # "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://cache.nixos.org"
  ];
  nix.settings.trusted-users = [ "yueyinqiu" ];

  boot.supportedFilesystems = [ "ntfs" ];

  # powerManagement.cpuFreqGovernor = "performance";
  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
    }
  ];
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    spiceUSBRedirection.enable = true;
  };
  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.connections."qemu:///system".networks = [
    {
      definition = nixvirt.lib.network.writeXML (
        nixvirt.lib.network.templates.bridge {
          uuid = "c035e1de-ee53-416a-b4c9-508fa48f4111";
          subnet_byte = 71;
        }
      );
      active = true;
    }
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --remember --cmd ${pkgs.bash}/bin/bash";
    };
  };

  users.users.yueyinqiu = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "podman"
      "libvirtd"
      "libvirt"
      "kvm"
      "nix-daemon-proxy"
    ];
  };

  services.beyond-tunnel.enable = true;
  services.openssh.enable = true;
  services.udisks2.enable = true;
  programs.niri.enable = true;
  services.flatpak.enable = true;
  system.stateVersion = "26.05"; # never change this, even it's updated
}
