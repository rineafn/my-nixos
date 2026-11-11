{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ani-cli
    mangal
    mov-cli
    trackma

    asciiquarium
    cava
    cbonsai
    cowsay
    figlet
    genact
    lavat
    lolcat
    nms
    peaclock
    pipes-rs
    sl
    tty-clock

    curseofwar
    moon-buggy
    ninvaders
    nsnake
    nudoku
    tint
    typioca
  ];
}
