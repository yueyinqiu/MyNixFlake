{ ... }:
{
  my.sing-box.instances.mainland = {
    files = [
      ./route.json
      ./outbounds-selector.json.example
      ./outbounds.json.example
    ];
    port = 29662;
    manager = 35169;
  };
}
