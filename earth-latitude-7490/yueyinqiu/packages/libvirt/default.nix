{ pkgs, lib, nixvirt, ... }: {
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
            # virsh start win11
            # virt-viewer win11 --attach
            # if there is no disk displayed during installation, click Load Driver, select  virtio-win/viostor/w11/amd64
            definition = nixvirt.lib.domain.writeXML (nixvirt.lib.domain.templates.windows
            {
                name = "win11";
                uuid = "fbcd0e7c-c37b-404f-b7ec-16e609927087";
                memory = { count = 8; unit = "GiB"; };
                # qemu-img create -f qcow2 /home/yueyinqiu/VirtualMachines/win11/storage.qcow2 128G
                storage_vol = /home/yueyinqiu/VirtualMachines/win11/storage.qcow2;
                install_vol = /home/yueyinqiu/VirtualMachines/win11/install.iso;
                nvram_path = /home/yueyinqiu/VirtualMachines/win11/nvram.nvram;
                virtio_net = true;
                virtio_drive = true;
                install_virtio = true;
            });
        }
    ];
}