{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    calibre
    feh
    flameshot
    gthumb
    grim
    imv
    inkscape
    kdePackages.kdenlive
    libresprite
    losslesscut-bin
    mediainfo
    mpv
    obs-studio
    pavucontrol
    pdfarranger
    peek
    photoqt
    pinta
    playerctl
    satty
    simplescreenrecorder
    slurp
    vlc
    glaxnimate
    synfigstudio
  ];
}
