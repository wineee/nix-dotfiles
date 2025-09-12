{
  inputs,
  config,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rewine";
  home.homeDirectory = "/home/rewine";

  home.packages =
    with pkgs;
    [
      jetbrains-mono

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
      patchelf
      just
      gh
      lnav

      # wmenu
      rofi

      #debian-devscripts

      # nix
      nh
      nix-index
      nix-update
      nix-output-monitor
      nix-du
      nix-tree
      nix-update
      nix-init
      comma
      manix
      nixfmt-rfc-style
      nixpkgs-lint
      nixpkgs-review
      deadnix

      nixgl.nixGLIntel

      hugo
      cachix

      # chat
      pineapple-pictures

      # wayland
      grim
      hyprpicker
      wl-clipboard
      wlr-randr
      lswt
      wlrctl
      wayfarer

      # ui
      emacs-pgtk
      wayvnc
    ]
    ++ (with inputs.rew.packages.${system}; [
      wayland-debug
      wldbg
      xcursor-viewer
      wlhax
      git-commit-helper
    ]);

  fonts.fontconfig.enable = true; # Allow fontconfig to discover fonts in home.packages

  programs.fish.enable = true;

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
      url."https://github.com/".insteadOf = [
        "gh:"
        "github:"
      ];
    };
  };

  programs.bat.enable = true;
  programs.fzf.enable = true;

  home.sessionPath = [ "$HOME/.emacs.d/bin" ];

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
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

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
