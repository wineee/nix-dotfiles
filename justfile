all: up home system

up:
    nix flake update
home:
    nix run .#home -v -L
system:
    nix run .#system -v -L
gc:
    nix store gc
    nix store optimise
