{ pkgs, system, lib, ... }:
{
  config = {
    nixpkgs.hostPlatform = system;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "github-copilot-cli"
    ];
    system-manager.allowAnyDistro = true;
    system-graphics.enable = true;

    environment.systemPackages = with pkgs; [
      fastfetch
      htop
      ugrep
      ripgrep
      yazi
      fd
      libtree # ldd as a tree
      tldr
      duf
      ncdu
      pstree
      cloc
      eza

      # dev
      nodejs
      nil
      neocmakelsp
      hugo
      cachix

      # ui
      pineapple-pictures

      # wayland
      grim
      hyprpicker
      wl-clipboard
      wlr-randr
      lswt
      wlrctl
      # ai
      github-copilot-cli
      opencode
      qwen-code
    ];
  };
}
