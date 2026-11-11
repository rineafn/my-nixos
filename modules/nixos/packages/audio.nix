{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    calf
    carla
    easyeffects
    guitarix
    helvum
    lsp-plugins
    qpwgraph
    tuxguitar

    cmus
    deadbeef
    ncmpcpp
    strawberry
    waylyrics
  ];
}
