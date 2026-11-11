{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    drawio
    figma-linux
    gimp
    krita
    libreoffice-stable
    lunacy
    lxappearance
    lyx
    obsidian
    pcmanfm
    pencil
    texliveMedium
    thunderbird
    xarchiver
    xournalpp
  ];
}
