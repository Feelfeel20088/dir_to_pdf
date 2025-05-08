{
  description = "Converts an entire directory to a pdf used just once to convert my entire program to a pdf for my AP";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
        let
            pkgs = import nixpkgs {
            inherit system;
        };
        in {
        packages.default = pkgs.rustPlatform.buildRustPackage {
            pname = "dir_to_pdf";
            version = "0.1.0";

            src = ./.;

            cargoLock = {
                lockFile = ./Cargo.lock;
            };
        };
      });
}
