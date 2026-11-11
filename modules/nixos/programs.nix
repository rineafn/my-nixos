{ pkgs, ... }:

{
  programs = {
    steam.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    git = {
      enable = true;
      lfs.enable = true;
      config = {
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
        merge.conflictStyle = "zdiff3";
        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";
        delta = {
          navigate = true;
          line-numbers = true;
        };
      };
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        alsa-lib
        atk
        cairo
        curl
        dbus
        expat
        fontconfig
        freetype
        gdk-pixbuf
        glib
        gtk3
        icu
        libGL
        libx11
        libxcb
        libxcursor
        libxext
        libxfixes
        libxi
        libxinerama
        libxrandr
        libxrender
        libxtst
        mesa
        nss
        openssl
        pango
        stdenv.cc.cc
        zlib
      ];
    };
  };
}
