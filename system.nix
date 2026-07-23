{
  pkgs,
  system,
  lib,
  ...
}:
{
  config = {
    nixpkgs.hostPlatform = system;
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "github-copilot-cli"
      ];
    system-manager.allowAnyDistro = true;
    system-graphics.enable = true;
  };
}
