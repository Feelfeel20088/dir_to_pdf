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
                version = "0.1.2";

                src = pkgs.fetchFromGitHub {
                    owner = "Feelfeel20088";
                    repo = "dir_to_pdf";
                    rev = "b0d2ae9";
                    hash = "sha256-FmbGEG/nCARj1oYJjHJimnXTom4VAQIT912+faFu0gg=";
                };

                cargoLock = {
                    lockFile = ./Cargo.lock;
                };
            };
      });
}
