{
  description = "Home Manager configuration for Me QwQ";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    system-manager = {
      url = "github:numtide/system-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-system-graphics = {
      url = "github:soupglasses/nix-system-graphics";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rew = {
      url = "github:wineee/nur-packages";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      flake-utils,
      system-manager,
      nix-system-graphics,
      rew,
      ...
    }@inputs:
    let
      username = "deepin";
    in

    flake-utils.lib.eachDefaultSystem (system: {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs username system; };
      };

      systemConfigs.${username} = system-manager.lib.makeSystemConfig {
        modules = [
          nix-system-graphics.systemModules.default
                        {
                nix = {
                  settings = {
                    substituters = [
                      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
                      "https://rewine.cachix.org"
                      #"https://cache.garnix.io"
                      "https://cache.lix.systems"
                    ];
                    trusted-public-keys = [
                      "rewine.cachix.org-1:aOIg9PvwuSefg59gVXXxGIInHQI9fMpskdyya2xO+7I="
                      # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
                      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
                    ];
                    trusted-users = [ "rewine" "deepin" ];
                    experimental-features = "nix-command flakes";
                  };
                };
              }
          ({ ... }: {
            config = {
              nixpkgs.hostPlatform = system;
              system-manager.allowAnyDistro = true;
              system-graphics.enable = true;
            };
          })
        ];
      };
    });
}
