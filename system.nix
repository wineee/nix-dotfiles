{ pkgs, system, ... }:
{
  config = {
    nixpkgs.hostPlatform = system;
    system-manager.allowAnyDistro = true;
    system-graphics.enable = true;

    environment.systemPackages = with pkgs; [
      btop # Beautiful system monitor
      bat # Modern 'cat' with syntax highlighting
    ];
  };
}
