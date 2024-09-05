{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      mkShell = pkgs.mkShell.override { stdenv = pkgs.swift.stdenv; };
    in {
      devShells.${system}.default = mkShell {
        name = "swift-dev";
        shellHook = ''
          export _ZO_DATA_DIR="$(realpath ./.localzoxide)"
          export LD_LIBRARY_PATH="${pkgs.swiftPackages.Dispatch}/lib";
        '';
        buildInputs = [
          pkgs.pkg-config
          pkgs.swift
          pkgs.swift-format
          pkgs.swiftpm
          pkgs.sourcekit-lsp
          pkgs.swiftPackages.Foundation
          pkgs.swiftPackages.Dispatch
        ];
      };
    };
}

