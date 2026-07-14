{ pkgs, lib, config, nixvirt, ... }: {
    imports = [ 
        nixvirt.homeModules.default
    ];

    home.packages = with pkgs; [
        virt-manager
        virt-viewer
    ];
    
    virtualisation.libvirt.enable = true;
    virtualisation.libvirt.swtpm.enable = true;

    virtualisation.libvirt.connections."qemu:///session".domains =
    [
        {
            # if there is no disk displayed during installation, click Load Driver, select viostor/w11/amd64 in virtio-win
            # for network: netkvm
            # all: virtio-win-guest-tools.exe
            # To activate: irm https://get.activated.win | iex 
            definition = let
                base = nixvirt.lib.domain.templates.windows
                {
                    name = "win11";
                    uuid = "fbcd0e7c-c37b-404f-b7ec-16e609927087";
                    memory = { count = 4; unit = "GiB"; };
                    storage_vol = "${config.home.homeDirectory}/VirtualMachines/win11/storage.raw";
                    install_vol = "${config.home.homeDirectory}/VirtualMachines/win11/install.iso";
                    nvram_path = "${config.home.homeDirectory}/VirtualMachines/win11/nvram.nvram";
                    virtio_net = true;
                    virtio_drive = true;
                    install_virtio = true;
                };
            in
            nixvirt.lib.domain.writeXML (base // {
                devices = base.devices // {
                    disk = lib.lists.imap0 (i: disk:
                        if i == 0 then disk // {
                            driver = disk.driver // { type = "raw"; discard="ignore"; };
                        } else disk
                    ) base.devices.disk;
                };
            });
        }
        {
            definition = let
                base = nixvirt.lib.domain.templates.windows
                {
                    name = "win10";
                    uuid = "90d049a8-dca2-472e-8212-3019254df766";
                    memory = { count = 4; unit = "GiB"; };
                    storage_vol = "${config.home.homeDirectory}/VirtualMachines/win10/storage.qcow2";
                    install_vol = "${config.home.homeDirectory}/VirtualMachines/win10/install.iso";
                    nvram_path = "${config.home.homeDirectory}/VirtualMachines/win10/nvram.nvram";
                    virtio_net = true;
                    virtio_drive = true;
                    install_virtio = true;
                };
            in
            nixvirt.lib.domain.writeXML (base // {
                devices = base.devices // {
                    watchdog = { model = "itco"; action = "none"; };
                    controller = (base.devices.controller or []) ++ [
                        { type = "scsi"; index = 0; model = "virtio-scsi"; }
                    ];
                };
            });
        }
    ];

    my.r.virsh = ''
        virsh "$@"
    '';
    my.r.virsh-start = ''
        virsh start "$@"
    '';
    my.r.virsh-shutdown = ''
        virsh shutdown "$@"
    '';
    my.r.virsh-destroy = ''
        virsh destroy "$@"
    '';
    my.r.virt-viewer-attach = ''
        virt-viewer --attach "$@"
    '';

    my.r.virt-create-storage = ''
        # $1: storage.raw
        # $2: 80G
        qemu-img create -f raw -o preallocation=full,nocow=on "$1" "$2"
    '';
}