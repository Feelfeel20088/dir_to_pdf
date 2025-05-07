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
                pname = "my-rust-app";
                version = "0.1.0";

                src = fetchFromGitHub {
                    owner = "Feelfeel20088";
                    repo = "dir_to_pdf";
                    rev = "master";
                    hash = "sha256-03wxx0825cmyczrams1zhs5wvfjxjszbp6h78dg9ibgnhay75ny8";
                };

                cargoLock = {
                    lockFile = ./Cargo.lock;
                };
            };
      });
}
