{ pkgs, ... }: {
  home.packages = with pkgs; [
    ouch
  ];
  
  my.navi-cheats.ouch = ''
    $ archive: find . -maxdepth 1 -type f \( -name "*.zip" -o -name "*.tar*" -o -name "*.tgz" -o -name "*.gz" -o -name "*.7z" -o -name "*.rar" -o -name "*.zst" -o -name "*.bz2" -o -name "*.xz" \) --- --map my-bash-escape-std
    $ target: find . -maxdepth 1 --- --map my-bash-escape-std
    $ output: echo -e "archive.tar.gz\narchive.zip\narchive.7z" --- --map my-bash-escape-std

    # decompress any archive with ouch
    ouch decompress <file>

    # compress files or directory into archive
    ouch compress <target> <output>

    # list contents of an archive without extracting
    ouch list <archive>
  '';
}
