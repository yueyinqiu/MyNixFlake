{ ... }:
{
  my.proxies.pjlab = {
    files = [
      ./config.sh.example
      ./config.yaml
    ];
    port = 11294;
  };
}