{ ... }:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    opentabletdriver.enable = true;
  };

  security.rtkit.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  services = {
    fstrim.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
    };
    power-profiles-daemon.enable = true;
    upower.enable = true;
    libinput.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      extraConfig.pipewire."10-rates"."context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [
          44100
          48000
          88200
          96000
          176400
          192000
          352800
          384000
        ];
      };
    };
  };
}
