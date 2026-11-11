{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gh
    gitui
    jetbrains-toolbox
    just
    mesa-demos
    tmux
    xh
    zellij

    dive
    docker-compose
    lazydocker
    qemu

    litecli
    mariadb
    mycli
    pgcli
    postgresql
    sqlite

    gdb
    lldb
    ltrace
    perf
    strace
    valgrind

    bandwhich
    dnsutils
    doggo
    mtr
    netcat
    nmap
    tcpdump
    whois

    age
    sops
  ];
}
