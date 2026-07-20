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

  boot.kernelParams = [ 
    "pcie_aspm=off" 
  ];

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleSuspendKey="ignore";
    HandleHibernateKey="ignore";
    IdleAction="ignore";
  };
  services.upower.ignoreLid = true;
  
  # pcie_aspm=off is suggested by AI to fix the following issue:
  # $ sudo dmesg | grep -i "ath10k\|aer"
  # [    0.345636] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
  # [    0.508288] pcieport 0000:00:1c.0: AER: enabled with IRQ 120
  # [    0.508930] pcieport 0000:00:1c.2: AER: enabled with IRQ 121
  # [    5.899755] ath10k_pci 0000:02:00.0: enabling device (0000 -> 0002)
  # [    5.903788] ath10k_pci 0000:02:00.0: pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
  # [    6.110520] ath10k_pci 0000:02:00.0: qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1028:0310
  # [    6.110526] ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 1 testmode 0
  # [    6.110562] ath10k_pci 0000:02:00.0: firmware ver WLAN.RM.4.4.1-00309- api 6 features wowlan,ignore-otp,mfp crc32 0793bcf2
  # [    6.176415] ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
  # [    6.267446] ath10k_pci 0000:02:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp max-sta 32 raw 0 hwcrypto 1
  # [    6.457499] ath10k_pci 0000:02:00.0 wlp2s0: renamed from wlan0
  # [   18.038813] pcieport 0000:00:1c.2: AER: Correctable error message received from 0000:02:00.0
  # [   18.038824] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [   18.038828] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000001/00006000
  # [   18.038832] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [   35.491652] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [   35.491664] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [   35.491668] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [   35.491672] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [   35.491676] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [   50.586716] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [   50.586758] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [   50.586761] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=000000c0/00006000
  # [   50.586764] ath10k_pci 0000:02:00.0:    [ 6] BadTLP
  # [   50.586767] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [   50.586770] ath10k_pci 0000:02:00.0: AER:   Error of this Agent is reported first
  # [   56.951575] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [   56.951586] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [   56.951590] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [   56.951594] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [   56.951597] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [   59.818697] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [   59.818709] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [   59.818712] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [   59.818716] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [   59.818720] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  103.967824] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  103.967835] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  103.967839] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  103.967843] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  130.006346] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  130.006358] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  130.006362] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  130.006366] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  136.705015] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  136.705085] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  136.705089] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  136.705093] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  136.705096] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  153.720796] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  153.720807] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  153.720811] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  153.720815] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  153.720818] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  226.425886] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  226.425897] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  226.425901] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  226.425905] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  226.425908] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  281.794884] pcieport 0000:00:1c.2: AER: Correctable error message received from 0000:02:00.0
  # [  281.794896] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  281.794900] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000001/00006000
  # [  281.794904] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  310.530274] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  310.530286] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  310.530289] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  310.530294] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  385.829597] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  385.829631] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  385.829634] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  385.829639] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  385.906287] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  385.906298] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  385.906302] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  385.906305] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  385.906307] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  392.251773] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  392.251783] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  392.251786] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  392.251789] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  392.251792] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  393.734643] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  393.734656] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
  # [  393.734659] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00001080/00006000
  # [  393.734663] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  393.734665] ath10k_pci 0000:02:00.0:    [12] Timeout
  # [  403.095696] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  403.095721] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  403.095724] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=000000c1/00006000
  # [  403.095727] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  403.095730] ath10k_pci 0000:02:00.0:    [ 6] BadTLP
  # [  403.095733] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  403.095736] ath10k_pci 0000:02:00.0: AER:   Error of this Agent is reported first
  # [  428.712764] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  428.712778] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  428.712781] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  428.712786] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  428.751843] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  428.751855] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  428.751859] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  428.751863] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  428.751866] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  428.763975] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  428.763989] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  428.763994] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  428.764000] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  428.764005] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  428.784702] pcieport 0000:00:1c.2: AER: Correctable error message received from 0000:02:00.0
  # [  428.784713] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  428.784717] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000001/00006000
  # [  428.784721] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  428.805352] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  428.805364] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  428.805368] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  428.805372] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  428.805375] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  431.201021] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  431.201054] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  431.201058] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  431.201062] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  433.015809] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  433.015836] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
  # [  433.015842] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00001080/00006000
  # [  433.015847] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  433.015851] ath10k_pci 0000:02:00.0:    [12] Timeout
  # [  435.703254] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  435.703264] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  435.703268] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  435.703272] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  448.163443] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  448.163454] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  448.163457] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  448.163459] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  460.513296] pcieport 0000:00:1c.2: AER: Correctable error message received from 0000:02:00.0
  # [  460.513304] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  # [  460.513307] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000080/00006000
  # [  460.513309] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  460.548272] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  460.548280] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  460.548283] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  460.548285] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  460.548286] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  462.229168] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  462.229197] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
  # [  462.229201] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00001080/00006000
  # [  462.229206] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  462.229209] ath10k_pci 0000:02:00.0:    [12] Timeout
  # [  462.430895] pcieport 0000:00:1c.2: AER: Correctable error message received from 0000:02:00.0
  # [  462.430905] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  462.430907] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  462.430909] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  462.430910] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  471.825059] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  471.825071] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  471.825075] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  471.825079] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  471.825082] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP
  # [  471.950657] pcieport 0000:00:1c.2: AER: Multiple Correctable error message received from 0000:02:00.0
  # [  471.950672] ath10k_pci 0000:02:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  # [  471.950677] ath10k_pci 0000:02:00.0:   device [168c:003e] error status/mask=00000081/00006000
  # [  471.950683] ath10k_pci 0000:02:00.0:    [ 0] RxErr                  (First)
  # [  471.950689] ath10k_pci 0000:02:00.0:    [ 7] BadDLLP

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

  services.beyond-tunnel.enable = true;
  services.openssh.enable = true;
  services.udisks2.enable = true;
  programs.niri.enable = true;
  services.flatpak.enable = true;
  system.stateVersion = "26.05"; # never change this, even it's updated
}
