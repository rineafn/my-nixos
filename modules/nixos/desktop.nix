{ pkgs, ... }:

{
  services = {
    displayManager.ly.enable = true;
    xserver = {
      enable = true;
      windowManager.i3.enable = true;
      xkb.layout = "us";
    };
  };

  programs = {
    niri.enable = true;
    dconf.enable = true;
  };

  security.polkit.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
    systemPackages = [ pkgs.xwayland-satellite ];
  };
}
