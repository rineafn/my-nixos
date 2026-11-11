{
  palette,
  pkgs,
  ...
}:

let
  polybarPackage = pkgs.polybar.override {
    i3Support = true;
    pulseSupport = true;
  };

  polybar-launch = pkgs.writeShellApplication {
    name = "polybar-launch";
    runtimeInputs = [
      polybarPackage
      pkgs.coreutils
      pkgs.gawk
      pkgs.procps
      pkgs.xrandr
    ];
    text = ''
      pkill -u "$UID" -x polybar || true
      while pgrep -u "$UID" -x polybar >/dev/null; do
        sleep 0.5
      done

      while IFS= read -r monitor; do
        MONITOR=$monitor polybar --reload top >"/tmp/polybar-$monitor.log" 2>&1 &
      done < <(xrandr --query | awk '/ connected/ {print $1}')
    '';
  };
in
{
  home.packages = [
    polybarPackage
    polybar-launch
  ];

  xdg.configFile."polybar/config.ini".text = ''
    [colors]
    background = #E6${palette.raw.base}
    foreground = ${palette.text}
    primary = ${palette.blue}
    disabled = ${palette.overlay0}
    alert = ${palette.red}
    green = ${palette.green}

    [bar/top]
    monitor = ''${env:MONITOR:}
    width = 100%
    height = 28pt
    radius = 0
    background = ''${colors.background}
    foreground = ''${colors.foreground}

    border-size = 0
    padding-left = 3
    padding-right = 3
    module-margin = 2

    font-0 = JetBrainsMono Nerd Font:style=Regular:size=11;3
    font-1 = Symbols Nerd Font:style=Regular:size=12;3

    modules-left = launcher i3
    modules-center = title
    modules-right = pulseaudio battery date power

    cursor-click = pointer
    enable-ipc = true
    wm-restack = i3
    override-redirect = false
    line-size = 2

    [module/launcher]
    type = custom/text
    format = "󱄅"
    format-foreground = ''${colors.primary}
    click-left = rofi -show drun
    margin-right = 1

    [module/i3]
    type = internal/i3
    pin-workspaces = true
    show-urgent = true
    strip-wsnumbers = true
    index-sort = true

    label-focused = %name%
    label-focused-foreground = ''${colors.primary}
    label-focused-underline = ''${colors.primary}
    label-focused-padding = 2

    label-unfocused = %name%
    label-unfocused-foreground = ''${colors.disabled}
    label-unfocused-padding = 2

    label-urgent = %name%
    label-urgent-foreground = ''${colors.alert}
    label-urgent-underline = ''${colors.alert}
    label-urgent-padding = 2

    label-visible = %name%
    label-visible-foreground = ''${colors.foreground}
    label-visible-padding = 2

    [module/title]
    type = internal/xwindow
    format = <label>
    label = %title%
    label-maxlen = 50
    label-empty = Desktop
    label-foreground = ''${colors.disabled}

    [module/pulseaudio]
    type = internal/pulseaudio
    use-ui-max = false
    interval = 2
    format-volume = <ramp-volume> <label-volume>
    format-volume-foreground = ''${colors.foreground}
    label-volume = %percentage%%
    format-muted = 󰖁 Muted
    format-muted-foreground = ''${colors.disabled}
    ramp-volume-0 = 󰕿
    ramp-volume-1 = 󰖀
    ramp-volume-2 = 󰕾
    click-left = wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle &
    click-right = pavucontrol &

    [module/battery]
    type = internal/battery
    battery = BAT0
    adapter = ADP1
    full-at = 98

    format-charging = <animation-charging> <label-charging>
    format-charging-foreground = ''${colors.green}

    format-discharging = <ramp-capacity> <label-discharging>
    format-discharging-foreground = ''${colors.disabled}

    format-full = 󰁹 <label-full>
    format-full-foreground = ''${colors.green}

    label-charging = %percentage%%
    label-discharging = %percentage%%
    label-full = %percentage%%

    ramp-capacity-0 = 󰂎
    ramp-capacity-1 = 󰁺
    ramp-capacity-2 = 󰁻
    ramp-capacity-3 = 󰁼
    ramp-capacity-4 = 󰁽
    ramp-capacity-5 = 󰁾
    ramp-capacity-6 = 󰁿
    ramp-capacity-7 = 󰂀
    ramp-capacity-8 = 󰂁
    ramp-capacity-9 = 󰂂
    ramp-capacity-10 = 󰁹
    ramp-capacity-0-foreground = ''${colors.alert}
    ramp-capacity-1-foreground = ''${colors.alert}

    animation-charging-0 = 󰢏
    animation-charging-1 = 󰢐
    animation-charging-2 = 󰢑
    animation-charging-3 = 󰢒
    animation-charging-4 = 󰢓
    animation-charging-5 = 󰢔
    animation-charging-framerate = 750

    [module/date]
    type = internal/date
    interval = 1
    date = %b %d
    time = %H:%M
    label = %date%, %time%
    format-foreground = ''${colors.foreground}
    click-left = dunstify -u low -r 12345 "Calendar" "<tt>$(cal)</tt>" &

    [module/power]
    type = custom/text
    format = "󰐥"
    format-font = 2
    format-foreground = ''${colors.disabled}
    click-left = ~/.config/eww/scripts/toggle_widget.sh power &
  '';
}
