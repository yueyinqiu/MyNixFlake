{ pkgs, ... }:

let
  mihomo2singbox = pkgs.python3.pkgs.buildPythonApplication {
    pname = "mihomo2singbox";
    version = "0.1.0";

    format = "pyproject";

    src = pkgs.fetchFromGitHub {
      owner = "n-WN";
      repo = "mihomo2singbox";
      rev = "main";
      hash = "sha256-nVsvTuz4zmrQDwsEExv+XNzKI79MdwtcJQAZ6eciUxw=";
    };

    nativeBuildInputs = with pkgs.python3.pkgs; [
      hatchling
    ];

    propagatedBuildInputs = with pkgs.python3.pkgs; [
      pyyaml
    ];

    meta = with pkgs.lib; {
      description = "Mihomo (ClashMeta) 配置转换为 Sing-box 配置的转换工具";
      homepage = "https://github.com/n-WN/mihomo2singbox";
      license = licenses.mit;
      mainProgram = "mihomo2singbox";
    };
  };

in {
  home.packages = [
    mihomo2singbox
  ];
}