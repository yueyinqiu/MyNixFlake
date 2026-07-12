{
    appimageTools,
    fetchurl,
}:

let
    pname = "wechat";
    version = "4.1.1.4";
    src = fetchurl {
        url = "https://dldir1v6.qq.com/weixin/Universal/Linux/WeChatLinux_x86_64.AppImage";
        hash = "sha256-XxAvFnlljqurGPDgRr+DnuCKbdVvgXBPh02DLHY3Oz8=";
    };

    appimageContents = appimageTools.extract {
        pname = pname;
        version = version;
        src = src;
        postExtract = ''
            patchelf --replace-needed libtiff.so.5 libtiff.so $out/opt/wechat/wechat
        '';
    };
in
appimageTools.wrapAppImage {
    pname = pname;
    version = version;
    src = appimageContents;
}
