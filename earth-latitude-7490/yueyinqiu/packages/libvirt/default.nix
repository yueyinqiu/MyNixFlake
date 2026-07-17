{
  pkgs,
  lib,
  config,
  nixvirt,
  ...
}:
{
  imports = [
    nixvirt.homeModules.default
  ];

  home.packages = with pkgs; [
    virt-manager
    virt-viewer
  ];

  virtualisation.libvirt.enable = true;
  virtualisation.libvirt.swtpm.enable = true;

  virtualisation.libvirt.connections."qemu:///session".domains = [
    {
      # if there is no disk displayed during installation, click Load Driver, select viostor/w11/amd64 in virtio-win
      # for network: netkvm
      # all: virtio-win-guest-tools.exe
      # To activate: irm https://get.activated.win | iex
      definition =
        let
          base = nixvirt.lib.domain.templates.windows {
            name = "w11";
            uuid = "fbcd0e7c-c37b-404f-b7ec-16e609927087";
            memory = {
              count = 4;
              unit = "GiB";
            };
            # storage_vol = "${config.home.homeDirectory}/.local/share/libvirt/images/w11/storage.raw";
            storage_vol = "${config.home.homeDirectory}/.local/share/libvirt/images/w11/storage.qcow2";
            install_vol = "${config.home.homeDirectory}/.local/share/libvirt/images/w11/install.iso";
            nvram_path = "${config.home.homeDirectory}/.local/share/libvirt/images/w11/nvram.nvram";
            virtio_net = true;
            virtio_drive = true;
            install_virtio = true;
          };
        in
        nixvirt.lib.domain.writeXML (
          base
          // {
            devices = base.devices // {
              disk = lib.lists.imap0 (
                i: disk:
                if i == 0 then
                  disk
                # // {
                #   driver = disk.driver // {
                #     type = "raw";
                #     discard = "ignore";
                #   };
                # }
                else
                  disk
              ) base.devices.disk;
              controller = (base.devices.controller or [ ]) ++ [
                {
                  type = "scsi";
                  index = 0;
                  model = "virtio-scsi";
                }
              ];
            };
          }
        );
    }
  ];

  my.r.libvirt-start = ''
    virsh start "$@"
  '';
  my.r.libvirt-shutdown = ''
    virsh shutdown "$@"
  '';
  my.r.libvirt-destroy = ''
    virsh destroy "$@"
  '';
  my.r.libvirt-attach = ''
    virt-viewer --attach "$@"
  '';

  # my.r.libvirt-create-storage = ''
  #   # $1: storage.raw
  #   # $2: 80G
  #   qemu-img create -f raw -o preallocation=full,nocow=on "$1" "$2"
  # '';

  my.r.libvirt-create-storage = ''
    # $1: storage.qcow2
    # $2: 128G
    qemu-img create -f qcow2 "$1" "$2"
  '';
}
