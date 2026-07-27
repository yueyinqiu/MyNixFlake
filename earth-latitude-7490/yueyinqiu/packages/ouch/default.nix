{ pkgs, ... }: {
  home.packages = with pkgs; [
    ouch
  ];
  
  my.navi-cheats = [
    ''
      % ouch

      # decompress any archive with ouch
      ouch decompress "<file>"
      $ file: find . -maxdepth 1 -type f \( -name "*.zip" -o -name "*.tar*" -o -name "*.tgz" -o -name "*.gz" -o -name "*.7z" -o -name "*.rar" -o -name "*.zst" -o -name "*.bz2" -o -name "*.xz" \)
    ''
    ''
      % ouch

      # compress files or directory into archive
      ouch compress "<target>" "<output>"

      $ target: find . -maxdepth 1
      $ output: echo -e "archive.tar.gz\narchive.zip\narchive.7z"
    ''
    ''
      % ouch

      # list contents of an archive without extracting
      ouch list "<file>"
      $ file: find . -maxdepth 1 -type f \( -name "*.zip" -o -name "*.tar*" -o -name "*.tgz" -o -name "*.gz" -o -name "*.7z" -o -name "*.rar" -o -name "*.zst" -o -name "*.bz2" -o -name "*.xz" \)
    ''
  ];
}
