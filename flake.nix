{
  description = "Home Manager configuration of raph";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    home-manager,
    fenix,
    utils,
    nvf,
    ...
  } @ inputs: let
    system = utils.lib.system.x86_64-linux;
    pkgs = import nixpkgs {inherit system;};
    fenixLib = fenix.packages.${system};
    rustToolchain = fenixLib.stable.toolchain;
    customNeovim = inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf.nix];
    };
    customNeovimFull = inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [./nvf-full.nix];
    };
  in {
    packages.${system} = {
      neovim = customNeovim.neovim;
      neovimFull = customNeovimFull.neovim;
    };
    homeConfigurations.raph = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit rustToolchain;
      };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        {home.packages = [customNeovim.neovim];}
        ./home.nix
      ];
      # to pass through arguments to home.nix
    };
  };
}
