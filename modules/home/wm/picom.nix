{ ... }:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    activeOpacity = 1.0;
    inactiveOpacity = 0.90;

    fade = true;
    fadeDelta = 4;
    fadeSteps = [
      0.02
      0.02
    ];

    shadow = true;
    shadowOffsets = [
      (-15)
      (-15)
    ];
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
      "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      "window_type = 'fullscreen'"
    ];

    opacityRules = [
      "100:fullscreen"
      "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
      "100:window_type = 'fullscreen'"
      "100:name *?= 'YouTube'"
    ];

    settings = {
      unredir-if-possible = true;
      corner-radius = 12;
      shadow-radius = 15;
      shadow-opacity = 0.5;

      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
        "window_type = 'fullscreen'"
      ];

      blur = {
        method = "dual_kawase";
        strength = 7;
        kern = "3x3box";
      };
      blur-background = true;
      blur-background-exclude = [
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
        "window_type = 'fullscreen'"
      ];

      animations = true;
      animation-stiffness = 200.0;
      animation-dampening = 22.0;
      animation-clamping = true;
      animation-mass = 1;
      animation-for-open-window = "zoom";
      animation-for-unmap-window = "squeeze";
      animation-for-menu-window = "slide-down";
      animation-for-transient-window = "slide-down";
      animation-for-workspace-switch-in = "zoom";
      animation-for-workspace-switch-out = "zoom";
    };
  };
}
