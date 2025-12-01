{
  description = "Home Manager configuration of raph";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    #   nix.url = "https://flakehub.com/f/DeterminateSystems/nix/2.30.2.tar.gz";
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
  };

  outputs = {
    nixpkgs,
    home-manager,
    fenix,
    utils,
    ...
  }:
  # utils.lib.eachDefaultSystem (
  # system: let
  let
    system = utils.lib.system.x86_64-linux;
    pkgs = import nixpkgs {inherit system;};
    fenixLib = fenix.packages.${system};
    rustToolchain = fenixLib.stable.toolchain;
  in {
    homeConfigurations.raph = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit rustToolchain;
      };

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [
        ./home.nix
      ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
  # );
}
