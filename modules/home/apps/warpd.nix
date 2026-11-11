{ palette, pkgs, ... }:

let
  warpd-toggle = pkgs.writeShellApplication {
    name = "warpd-toggle";
    runtimeInputs = [
      pkgs.procps
      pkgs.warpd
    ];
    text = ''
      if pkill -x warpd; then
        exit 0
      fi
      exec warpd --normal
    '';
  };
in
{
  home.packages = [
    pkgs.warpd
    warpd-toggle
  ];

  xdg.configFile."warpd/config".text = ''
    cursor_color: ${palette.red}
    cursor_size: 10
    indicator: none

    speed: 260
    max_speed: 1300
    acceleration: 600
    decelerator_speed: 60
    accelerator_acceleration: 1600

    left: h
    down: j
    up: k
    right: l
    top: H
    middle: M
    bottom: L
    start: 0
    end: $

    buttons: space m .
    oneshot_buttons: Return n /

    drag: v

    scroll_down: e
    scroll_up: r
    scroll_speed: 300
    scroll_max_speed: 2500

    accelerator: a
    decelerator: d

    exit: esc

    hint: F24
    hint2: F24
    grid: F24
    screen: F24
    history: F24
  '';
}
