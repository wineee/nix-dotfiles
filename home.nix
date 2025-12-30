{
  inputs,
  config,
  pkgs,
  username,
  ...
}:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages =
    with pkgs;
    [
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

      lnav

      systemctl-tui
      #debian-devscripts

      # nix
      nix-index
      nix-update
      nix-du
      nix-tree
      nix-init
      comma
      manix
      nixfmt-rfc-style
      nixpkgs-review
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

      # ai
      github-copilot-cli
      opencode
      qwen-code

      # ui
      wayvnc
    ]
    ++ (with inputs.rew.packages.${system}; [
      wayland-debug
      #wldbg
      #xcursor-viewer
      #wlhax
      git-commit-helper
    ]);

  # fonts.fontconfig.enable = true; # Allow fontconfig to discover fonts in home.packages

  programs.fish.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rewine";
        email = "luhongxu@deepin.org";
      };
      alias = {
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
    lfs.enable = false;
    #signing = {
    #  key = null; # gpg --full-generate-key
    #  signByDefault = true;
    #};
  };

  programs.delta = {
    enable = true;
    # Explicitly enable delta's git integration (automatic enablement is deprecated)
    enableGitIntegration = true;
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

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    g = "git";
    "..." = "cd ../..";
  };

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
