{ config, ... }: {
  services.udiskie.enable = true;
  home.file."udiskie".source = config.lib.file.mkOutOfStoreSymlink "/run/media/yueyinqiu";

  my.r.udiskie-power-off = ''
    udisksctl unmount -b "/dev/$@"
    udisksctl power-off -b "/dev/$@"
  '';
  
  my.navi-cheats.udiskie = ''
    $ device: lsblk -l -n -o NAME --- --map my-bash-escape-std

    # unmount a disk partition
    udisksctl unmount -b <device>

    # power off a disk device
    udisksctl power-off -b <device>
  '';
  
}
