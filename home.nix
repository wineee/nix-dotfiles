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
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      fira-code-symbols

      patchelf
      just

      lnav

      rustup

      #debian-devscripts
      antigravity
      kiro
      code-cursor

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
      (inputs.system-manager.packages.${pkgs.stdenv.hostPlatform.system}.default)

      gh
      bun

      neovide
      telegram-desktop
      logseq
      dms-shell
    ]
    ++ (with inputs.rew.packages.${pkgs.stdenv.hostPlatform.system}; [
      wayland-debug
      #wldbg
      #xcursor-viewer
      #wlhax
      git-commit-helper
    ]);

  fonts.fontconfig.enable = true; # Allow fontconfig to discover fonts in home.packages
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
