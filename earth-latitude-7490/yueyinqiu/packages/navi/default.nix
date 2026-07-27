{ ... }: {
  programs.navi.enable = true;
  programs.navi.enableBashIntegration = true;

  home.file.".local/share/navi/cheats/my-notes.cheat".text = ''
    % 虚拟机, kvm, virsh

    # 查看所有虚拟机状态
    virsh list --all

    # 启动指定虚拟机
    virsh start <vm_name>

    # 用图形界面连接虚拟机
    virt-viewer -a <vm_name>

    % 解压, ouch, zip, 7z

    # 解压任意格式到同名文件夹
    ouch decompress <file>
  '';
}
