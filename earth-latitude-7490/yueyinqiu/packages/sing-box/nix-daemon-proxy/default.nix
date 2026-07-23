{ ... }:
{
  my.sing-box.instances.nix-daemon = {
    files = [
      ./rules.json
    ];
    port = 23569;
    manager = 62751;
  };
}
