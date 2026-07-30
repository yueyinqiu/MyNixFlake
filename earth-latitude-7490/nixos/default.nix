{
  pkgs,
  nixvirt,
  config,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./nix-daemon-proxy
    ./easytier
    nixvirt.nixosModules.default
    ../../lib/dotnet-build.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "pcie_aspm=off"
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
  };
  services.upower.ignoreLid = true;

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

  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;

  boot.zswap.enable = true;
  swapDevices = [
    {
      device = "/swapfile";
      options = [ "discard" ];
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

  services.openssh.enable = true;
  services.udisks2.enable = true;
  programs.niri.enable = true;

  services.flatpak.enable = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    akvcam
  ];
  boot.kernelModules = [ "akvcam" ];
  environment.etc."akvcam/config.ini".text = ''
    [General]
    default_frame = ""

    [Cameras]
    cameras/size = 2

    [Cameras/1]
    cameras/1/type = output
    cameras/1/mode = mmap, userptr, rw
    cameras/1/description = Virtual Camera (Output)
    cameras/1/formats = 1
    cameras/1/videonr = 10

    [Cameras/2]
    cameras/2/type = capture
    cameras/2/mode = mmap, rw
    cameras/2/description = Integrated Camera (UVC)
    cameras/2/formats = 2
    cameras/2/videonr = 11

    [Formats]
    formats/size = 2

    # 1. 给 output 推流端用的格式（akvcam 的 output 只支持 RGB24 / BGR24）
    formats/1/format = RGB24
    formats/1/width = 1280
    formats/1/height = 720
    formats/1/fps = 30

    # 2. 伪装给腾讯会议看（capture 端）的格式，选通用性最好的 YUY2
    formats/2/format = YUY2
    formats/2/width = 1280
    formats/2/height = 720
    formats/2/fps = 30

    [Connections]
    connections/size = 1
    connections/1/connection = 1:2
  '';

  system.stateVersion = "26.05"; # never change this, even it's updated
}
