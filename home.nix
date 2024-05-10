{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rewine";
  home.homeDirectory = "/home/rewine";

  home.packages = with pkgs; [
    jetbrains-mono

    python3Packages.osc

    neofetch
    htop
    ugrep
    ripgrep
    ranger
    fd
    libtree # ldd as a tree
    tldr
    duf
    ncdu
    pstree
    cloc
    colorpicker
    eza
    patchelf

    # nix
    nh
    nix-index
    nix-update
    nix-output-monitor
    nix-du
    nix-tree
    nix-update
    nix-init
    nvd
    comma
    manix
    nixpkgs-fmt
    nixpkgs-lint
    nixpkgs-review

    nixgl.nixGLIntel
    
    nodejs
    nodePackages.npm
    yarn
    hugo
    cachix
    v2raya
    (writeShellScriptBin "et" "${config.programs.emacs.package}/bin/emacs -nw $@")

    # chat
    telegram-desktop
    cinny

    pineapple-pictures
  ];

  fonts.fontconfig.enable = true; # Allow fontconfig to discover fonts in home.packages

  programs.fish.enable = true;
  programs.zsh = {
    enable = true;
    # oh-my-zsh.enable = true;
  };
  #environment.pathsToLink = [ "/share/zsh" ];

  programs.git = {
    enable = true;
    userName = "rewine";
    userEmail = "luhongxu@deepin.org";
    delta.enable = true;
    lfs.enable = false;
    signing = {
      key = null; # gpg --full-generate-key
      #signByDefault = true;
    };
    aliases = {
      co = "checkout";
      ci = "commit";
      cia = "commit --amend";
      s = "status";
      st = "status";
      b = "branch";
      p = "pull --rebase";
      pu = "push";
      d = "diff";
    };
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.compression = 0;
      http.postBuffer = 1048576000;
      protocol."https".allow = "always";
      url."https://github.com/".insteadOf = [ "gh:" "github:" ];
    };
  };

  programs.bat.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-gtk3;
  };
  home.sessionPath = [ "$HOME/.emacs.d/bin" ];

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      coc.enable = true;
      plugins = with pkgs.vimPlugins; [
        fugitive
        vim-nix
        {
          plugin = vim-startify;
          config = "let g:startify_change_to_vcs_root = 0";
        }
      ];
      extraConfig = ''
        set whichwrap+=<,>,[,],h,l
      '';
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    g = "git";
    "..." = "cd ../..";
  };
  
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
