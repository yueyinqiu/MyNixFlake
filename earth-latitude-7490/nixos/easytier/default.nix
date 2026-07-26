{ ... }: {
  services.easytier.enable = true;
  services.easytier.instances.default.configFile = "/etc/easytier/default.toml";
  # To generate the configuration file, just run:
  # sudo easytier-core -d --network-name xxx --network-secret xxx -e xxx
  #
  # Then:
  # sudo mkdir -p /etc/easytier
  # sudo nano /etc/easytier/default.toml
}
