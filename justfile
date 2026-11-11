default:
    @just --list

switch:
    nh os switch

boot:
    nh os boot

test:
    nh os test

update:
    nix flake update

update-input input:
    nix flake update {{ input }}

fmt:
    nix fmt

check:
    nix flake check

lint:
    statix check .
    deadnix .

clean:
    nh clean all --keep 5 --keep-since 14d

build:
    nix build .#nixosConfigurations.nixos.config.system.build.toplevel --no-link --print-out-paths
