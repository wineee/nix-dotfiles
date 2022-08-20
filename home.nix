{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rewine";
  home.homeDirectory = "/home/rewine";

  home.packages = with pkgs; [
    htop
    (writeShellScriptBin "et" "${config.programs.doom-emacs.package}/bin/emacs -nw $@")
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

  programs.doom-emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    doomPrivateDir = ./doom.d;
    emacsPackagesOverlay = self: super: {
     magit-delta = super.magit-delta.overrideAttrs (esuper: {
       buildInputs = esuper.buildInputs ++ [ pkgs.git ];
     });
    };
    extraPackages = with pkgs; [
      fd
      findutils
      ripgrep
    ];
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
