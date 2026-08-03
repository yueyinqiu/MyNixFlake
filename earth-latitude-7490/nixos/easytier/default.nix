{ ... }: {
  services.easytier.enable = true;
  services.easytier.instances.s2429.configFile = "/etc/easytier/s2429.toml";
  # To generate the configuration file, just run:
  # sudo easytier-core -d --network-name xxx --network-secret xxx -e xxx
  #
  # Then:
  # sudo mkdir -p /etc/easytier
  # sudo nano /etc/easytier/s2429.toml

  services.easytier.instances.easytier-pro = {
    configServer = "$CONFIG_SERVER";
    environmentFiles = [
      # CONFIG_SERVER=xxxxxxxx
      "/etc/easytier/easytier-pro.env"
    ];
    extraArgs = [
      "--secure-mode=true"
    ];
  };
}
