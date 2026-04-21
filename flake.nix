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
      username = let u = builtins.getEnv "USER"; in if u == "" then "rewine" else u;
      lib = nixpkgs.lib;
    in

    flake-utils.lib.eachDefaultSystemPassThrough (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
          extraSpecialArgs = { inherit inputs username system; };
        };

        apps.${system} = {
          home = {
            type = "app";
            program = toString (pkgs.writeShellScript "hm-switch" ''
              exec ${lib.getExe home-manager.packages.${system}.home-manager} switch --flake . --impure "$@"
            '');
          };
          system = {
            type = "app";
            program = toString (pkgs.writeShellScript "sys-switch" ''
              exec sudo ${lib.getExe system-manager.packages.${system}.default} switch --flake . "$@"
            '');
          };
        };

        systemConfigs.default = system-manager.lib.makeSystemConfig {
          modules = [
            nix-system-graphics.systemModules.default
            ./system.nix
          ];
          specialArgs = { inherit inputs system; };
        };
      }
    );
}
