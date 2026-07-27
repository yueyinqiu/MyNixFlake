{ ... }:
{
  my.sing-box.instances.ailab = {
    files = [
      ./route.json
      ./outbounds.json
    ];
    port = 25563;
    manager = 11614;
  };

  my.r.sing-box-ailab-start-vpn = ''
    echo "VNC: 127.0.0.1:52495 Password: vnc"
    mkdir -p "$HOME/.atrust-data/ailab"
    docker run -ti \
        --rm \
        --device /dev/net/tun \
        --cap-add NET_ADMIN \
        --sysctl net.ipv4.conf.default.route_localnet=1 \
        -v "$HOME/.atrust-data/ailab:/root" \
        -p 127.0.0.1:52495:5901 \
        -p 127.0.0.1:59553:1080 \
        --dns 114.114.114.114 \
        -e URLWIN=1 \
        -e PASSWORD=vnc \
        hagb/docker-atrust
    # vnc: 127.0.0.1:52495 (vnc)
    # proxy: socks5h://127.0.0.1:59553
  '';
}
