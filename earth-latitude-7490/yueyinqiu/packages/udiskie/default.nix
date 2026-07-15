{ config, ... }: {
  services.udiskie.enable = true;
  home.file."udiskie".source = config.lib.file.mkOutOfStoreSymlink "/run/media/yueyinqiu";

  my.r.udiskie-status = ''
    udisksctl status
  '';
  my.r.udiskie-power-off = ''
    udisksctl unmount -b "/dev/$@"
    udisksctl power-off -b "/dev/$@"
  '';
}
