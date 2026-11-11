{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    arandr
    brightnessctl
    i3lock-color
    libnotify
    networkmanagerapplet
    scrcpy
    wl-clipboard
    xclip
    xsel
    xss-lock
  ];
}
