all: up hm sys

up:
    nix flake update
hm:
    nix run -v -L
sys:
    sudo system-manager switch --flake .
