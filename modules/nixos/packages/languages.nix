{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bear
    ccache
    clang
    clang-tools
    cmake
    cppcheck
    gcc
    gnumake
    mold
    ninja
    pkg-config
    sfml

    cargo
    clippy
    rust-analyzer
    rustc
    rustfmt
    rustup

    go
    go-tools
    goimports-reviser
    gopls
    gotools

    zig
    zls

    basedpyright
    python3
    ruff

    nodejs
    prettierd
    typescript-language-server
    vscode-langservers-extracted

    jdk
    jdt-language-server

    lua
    lua-language-server
    stylua

    deadnix
    nil
    nixfmt
    statix

    shellcheck
    shfmt
    tree-sitter
  ];
}
