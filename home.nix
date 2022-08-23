{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rewine";
  home.homeDirectory = "/home/rewine";

  home.packages = with pkgs; [
    htop
    (writeShellScriptBin "et" "${config.programs.emacs.package}/bin/emacs -nw $@")
  ];

  programs.git = {
    enable = true;
    userName = "rewine";
    userEmail = "lhongxu@outlook.com";
  };

  programs.bat.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.exa.enable = true;

  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGitNativeComp;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
  
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
