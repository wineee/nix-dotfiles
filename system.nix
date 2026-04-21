{ pkgs, system, lib, inputs, ... }:
{
  config = {
    nixpkgs.hostPlatform = system;
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "github-copilot-cli"
    ];
    system-manager.allowAnyDistro = true;
    system-graphics.enable = true;

    environment.systemPackages = with pkgs; [
      neovim
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
      systemctl-tui

      # wayland
      grim
      hyprpicker
      wl-clipboard
      lswt
      wlrctl
      (inputs.system-manager.packages.${system}.default)
    ];
  };
}
