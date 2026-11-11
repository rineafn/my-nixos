{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dmidecode
    ethtool
    htop
    hwinfo
    inxi
    lshw
    nvme-cli
    pciutils
    smartmontools
    usbutils

    curl
    fd
    file
    jq
    p7zip
    psmisc
    ripgrep
    tree
    unzip
    wget
    yq-go
    zip

    fuse
    icu
  ];
}
