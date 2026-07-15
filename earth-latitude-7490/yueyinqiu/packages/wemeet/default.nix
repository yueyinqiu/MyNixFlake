# 一些窗口显示、摄像头会有问题
# { pkgs, ... }: {
#     my.r.wemeet = ''
#         "${pkgs.wemeet}/bin/wemeet"
#     '';
# }

{ ... }: {
  services.flatpak.packages = [
    "flathub:app/com.tencent.wemeet/x86_64/stable"
  ];
  my.r.wemeet = "flatpak run com.tencent.wemeet";
}
